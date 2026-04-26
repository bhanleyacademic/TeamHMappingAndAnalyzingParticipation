import uuid
from django.db import migrations, models


def populate_kumu_tokens(apps, schema_editor):
    Dataset = apps.get_model('analysis', 'Dataset')
    for ds in Dataset.objects.all():
        ds.kumu_token = uuid.uuid4()
        ds.save(update_fields=['kumu_token'])


class Migration(migrations.Migration):

    dependencies = [
        ('analysis', '0002_expand_state_field'),
    ]

    operations = [
        # Step 1: add column without unique constraint, nullable so existing rows don't error
        migrations.AddField(
            model_name='dataset',
            name='kumu_token',
            field=models.UUIDField(null=True, editable=False),
        ),
        # Step 2: populate unique UUIDs for all existing rows
        migrations.RunPython(populate_kumu_tokens, migrations.RunPython.noop),
        # Step 3: make non-null and unique
        migrations.AlterField(
            model_name='dataset',
            name='kumu_token',
            field=models.UUIDField(default=uuid.uuid4, unique=True, editable=False),
        ),
    ]
