## Creating fake data in Django  

Django has an [easy way to add custom commands](https://docs.djangoproject.com/en/3.0/howto/custom-management-commands/) to your proyect.   

Let's build a custom command named `fakequestions`. It will create fake data of `Question` & `Answer` models.  Credit to misago proyect for most of this code.  


```
# faker/management/commands/createfakequestions.py

import random
import time
from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand
from faker import Factory
from ...questions import get_fake_question


User = get_user_model()

class Command(BaseCommand):
    help = "Creates random questions for dev and testing purposes."

    def add_arguments(self, parser):
        parser.add_argument(
            "questions",
            help="number of questions to create",
            nargs="?",
            type=int,
            default=5,
        )

    # this will be executed when we run $python manage.py createfakequestions
    def handle(self, *args, **options):
        items_to_create = options["questions"]
        fake = Factory.create()
        message = "Creating %s fake questions...\n"
        self.stdout.write(message % items_to_create)

        created_questions = 0
        start_time = time.time()
        show_progress(self, created_questions, items_to_create)

        while created_questions < items_to_create:
            if random.randint(0, 100) > 90:
                starter = None
            else:
                starter = User.objects.order_by("?").last()

            # create a question & an answer & link them together
            question = get_fake_question(fake, starter)
            question.save()

            created_questions += 1           

        total_time = time.time() - start_time
        total_humanized = time.strftime("%H:%M:%S", time.gmtime(total_time))
        message = "\nSuccessfully created %s fake questions in %s"
        self.stdout.write(message % (created_questions, total_humanized))

```   
```
# faker/questions.py

from django.utils import timezone

from ..questions.models import Question
from .englishcorpus import EnglishCorpus
from .answers import get_fake_answer


corpus_short = EnglishCorpus(max_length=150)

def get_fake_question(fake, starter=None):
    question = _create_base_question(fake)
    question.first_answer = get_fake_answer(fake, question, starter)
    question.save(update_fields=["first_answer"])
    return question

def _create_base_question(fake):
    started_on = timezone.now()
    question = Question(
        started_on=started_on,
        starter_name="-",
        starter_slug="-",
        last_question_on=started_on,
        last_poster_name="-",
        last_poster_slug="-",
        replies=0,
    )

    # Sometimes question ends with slug being set to empty string
    while not question.slug:
        question.set_title(corpus_short.random_sentence())

    question.save()

    return question


```  

```  

# faker/answers.py  

import random
from django.utils import timezone
from ..questions.checksums import update_answer_checksum
from ..questions.models import Answer
from .englishcorpus import EnglishCorpus
from .users import get_fake_username

corpus = EnglishCorpus()

def get_fake_answer(fake, question, poster=None):
    original, parsed = get_fake_answer_content(fake)
    posted_on = timezone.now()

    answer = Answer.objects.create(
        # category=thread.category,
        question=question,
        question_answer_poster=poster,
        poster_name=poster.username if poster else get_fake_username(fake),
        # content=original,
        original=original,
        parsed=parsed,
        posted_on=posted_on,
        updated_on=posted_on,
    )
    update_answer_checksum(answer)
    question.save(update_fields=["checksum"])
    return answer

def get_fake_answer_content(fake):
    raw = []
    parsed = []

    if random.randint(0, 100) > 90:
        paragraphs_to_make = random.randint(1, 2)
    else:
        paragraphs_to_make = random.randint(1, 2)
    for _ in range(paragraphs_to_make):
        sentences_to_make = random.randint(1, 2)
        raw.append(" ".join(corpus.random_sentences(sentences_to_make)))
        parsed.append("<p>%s</p>" % raw[-1])

    return "\n\n".join(raw), "\n".join(parsed)

```


