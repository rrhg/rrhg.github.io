```
from hashlib import sha256


def make_checksum(parsed, unique_values=None):
    unique_values = unique_values or []
    seeds = [parsed] + [str(v) for v in unique_values]

    return sha256("+".join(seeds).encode("utf-8")).hexdigest()
    
def is_question_valid(question):
    valid_checksum = make_question_checksum(question)
    return question.checksum == valid_checksum


def make_question_checksum(question):
    question_seeds = [str(v) for v in (question.id, str(question.posted_on.date()))]
    return make_checksum(question.parsed, question_seeds)


def update_question_checksum(question):
    question.checksum = make_question_checksum(question)
    return question.checksum
    
question = Question.objects.create(
    poster=poster,
    parsed=parsed,
    posted_on=posted_on,
    updated_on=posted_on,
    )
update_question_checksum(question)
question.save(update_fields=["checksum"])
```
