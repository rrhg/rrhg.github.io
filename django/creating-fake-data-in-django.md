## Creating fake data in Django  

Django has an [easy way to add custom commands](https://docs.djangoproject.com/en/3.0/howto/custom-management-commands/) to your proyect.   

Let's build a custom command named `fakequestions`. It will create fake data of `Question` & `Answer` models.  

```
# createfakequestions.py

import random
import time

from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand
from faker import Factory

# from ....categories.models import Category
from ....core.management.progressbar import show_progress
from ....questions.models import Question
from ...questions import (
    # get_fake_closed_thread,
    # get_fake_hidden_thread,
    get_fake_question,
    # get_fake_unapproved_thread,
)

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

    def handle(
        self, *args, **options
    ):  # pylint: disable=too-many-locals, too-many-branches
        items_to_create = options["questions"]
        fake = Factory.create()

        # categories = list(Category.objects.all_categories())

        message = "Creating %s fake questions...\n"
        self.stdout.write(message % items_to_create)

        created_questions = 0
        start_time = time.time()
        show_progress(self, created_questions, items_to_create)

        while created_questions < items_to_create:
            # category = random.choice(categories)

            # 10% chance thread poster is anonymous
            if random.randint(0, 100) > 90:
                starter = None
            else:
                starter = User.objects.order_by("?").last()

            ########################################
            # There's 10% chance thread is closed
            # if random.randint(0, 100) > 90:
                # question = get_fake_closed_question(fake, category, starter)

            # # There's further 5% chance question is hidden
            # elif random.randint(0, 100) > 95:
                # if random.randint(0, 100) > 90:
                    # hidden_by = None
                # else:
                    # hidden_by = User.objects.order_by("?").last()

                # question = get_fake_hidden_question(fake, category, starter, hidden_by)

            # # And further 5% chance question is unapproved
            # elif random.randint(0, 100) > 95:
                # question = get_fake_unapproved_question(fake, category, starter)

            # # Default, standard question
            # else:
                # question = get_fake_question(fake, category, starter)
            question = get_fake_question(fake, starter)

            ################################################

            question.synchronize()
            question.save()

            created_questions += 1
            show_progress(self, created_questions, items_to_create, start_time)

        pinned_questions = random.randint(0, int(created_questions * 0.025)) or 1
        self.stdout.write("\nPinning %s questions..." % pinned_questions)

        for _ in range(0, pinned_questions):
            question = Question.objects.order_by("?")[:1][0]
            if random.randint(0, 100) > 90:
                question.weight = 2
            else:
                question.weight = 1
            question.save()

        # for category in categories:
            # category.synchronize()
            # category.save()

        total_time = time.time() - start_time
        total_humanized = time.strftime("%H:%M:%S", time.gmtime(total_time))
        message = "\nSuccessfully created %s fake questions in %s"
        self.stdout.write(message % (created_questions, total_humanized))

```   
```
# faker/questions.py

import random
import time

from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand
from faker import Factory

# from ....categories.models import Category
from ....core.management.progressbar import show_progress
from ....questions.models import Question
from ...questions import (
    # get_fake_closed_thread,
    # get_fake_hidden_thread,
    get_fake_question,
    # get_fake_unapproved_thread,
)

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

    def handle(
        self, *args, **options
    ):  # pylint: disable=too-many-locals, too-many-branches
        items_to_create = options["questions"]
        fake = Factory.create()

        # categories = list(Category.objects.all_categories())

        message = "Creating %s fake questions...\n"
        self.stdout.write(message % items_to_create)

        created_questions = 0
        start_time = time.time()
        show_progress(self, created_questions, items_to_create)

        while created_questions < items_to_create:
            # category = random.choice(categories)

            # 10% chance thread poster is anonymous
            if random.randint(0, 100) > 90:
                starter = None
            else:
                starter = User.objects.order_by("?").last()

            ########################################
            # There's 10% chance thread is closed
            # if random.randint(0, 100) > 90:
                # question = get_fake_closed_question(fake, category, starter)

            # # There's further 5% chance question is hidden
            # elif random.randint(0, 100) > 95:
                # if random.randint(0, 100) > 90:
                    # hidden_by = None
                # else:
                    # hidden_by = User.objects.order_by("?").last()

                # question = get_fake_hidden_question(fake, category, starter, hidden_by)

            # # And further 5% chance question is unapproved
            # elif random.randint(0, 100) > 95:
                # question = get_fake_unapproved_question(fake, category, starter)

            # # Default, standard question
            # else:
                # question = get_fake_question(fake, category, starter)
            question = get_fake_question(fake, starter)

            ################################################

            question.synchronize()
            question.save()

            created_questions += 1
            show_progress(self, created_questions, items_to_create, start_time)

        pinned_questions = random.randint(0, int(created_questions * 0.025)) or 1
        self.stdout.write("\nPinning %s questions..." % pinned_questions)

        for _ in range(0, pinned_questions):
            question = Question.objects.order_by("?")[:1][0]
            if random.randint(0, 100) > 90:
                question.weight = 2
            else:
                question.weight = 1
            question.save()

        # for category in categories:
            # category.synchronize()
            # category.save()

        total_time = time.time() - start_time
        total_humanized = time.strftime("%H:%M:%S", time.gmtime(total_time))
        message = "\nSuccessfully created %s fake questions in %s"
        self.stdout.write(message % (created_questions, total_humanized))
```  

```  

# faker/answers.py  

import random

from django.utils import timezone

from ..questions.checksums import update_answer_checksum
from ..questions.models import Answer
# from ..questions.models import Question
from .englishcorpus import EnglishCorpus
from .users import get_fake_username

PLACEKITTEN_URL = "https://placekitten.com/g/%s/%s"

corpus = EnglishCorpus()


def get_fake_answer(fake, question, poster=None):
    original, parsed = get_fake_answer_content(fake)
    posted_on = timezone.now()
    
    # print('##############################################')
    # print('         from faker/answers.py              ')
    # print('         answer = '+str(answer))
    # print('##############################################')



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


# def get_fake_unapproved_post(fake, thread, poster=None):
    # post = get_fake_post(fake, thread, poster)
    # post.is_unapproved = True
    # post.save(update_fields=["is_unapproved"])
    # return post


# def get_fake_hidden_post(fake, thread, poster=None, hidden_by=None):
    # post = get_fake_post(fake, thread, poster)
    # post.is_hidden = True

    # if hidden_by:
        # post.hidden_by = hidden_by
        # post.hidden_by_name = hidden_by.username
        # post.hidden_by_slug = hidden_by.slug
    # else:
        # post.hidden_by_name = fake.first_name()
        # post.hidden_by_slug = post.hidden_by_name.lower()

    # post.save(
        # update_fields=["is_unapproved", "hidden_by", "hidden_by_name", "hidden_by_slug"]
    # )

    # return post


def get_fake_answer_content(fake):
    raw = []
    parsed = []

    if random.randint(0, 100) > 90:
        paragraphs_to_make = random.randint(1, 2)
        # paragraphs_to_make = random.randint(1, 20)
    else:
        paragraphs_to_make = random.randint(1, 2)
        # paragraphs_to_make = random.randint(1, 5)

    for _ in range(paragraphs_to_make):
        # if random.randint(0, 100) > 95:
            # cat_width = random.randint(1, 16) * random.choice([100, 90, 80])
            # cat_height = random.randint(1, 12) * random.choice([100, 90, 80])

            # cat_url = PLACEKITTEN_URL % (cat_width, cat_height)

            # raw.append("!(%s)" % cat_url)
            # parsed.append(' here goes an img element ' % cat_url)
            # # parsed.append('<p><img src="%s" alt=""/></p>' % cat_url)
        # else:
            # if random.randint(0, 100) > 95:
                # sentences_to_make = random.randint(1, 20)
            # else:
                # sentences_to_make = random.randint(1, 7)
            # raw.append(" ".join(corpus.random_sentences(sentences_to_make)))
            # parsed.append("<p>%s</p>" % raw[-1])

        sentences_to_make = random.randint(1, 2)
        raw.append(" ".join(corpus.random_sentences(sentences_to_make)))
        parsed.append("<p>%s</p>" % raw[-1])


    return "\n\n".join(raw), "\n".join(parsed)

```


