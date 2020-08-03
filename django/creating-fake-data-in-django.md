## Creating fake data in Django  

Django has an [easy way to add custom commands](https://docs.djangoproject.com/en/3.0/howto/custom-management-commands/) to your proyect.   

Let's build a custom command named `fakequestions`. It will create fake data of `Question` & `Answer` models.  

```
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

