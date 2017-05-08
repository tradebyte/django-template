"""Sampleclass to test a model."""
from django.test import TestCase


class SimpleTest(TestCase):
    """
    Simple test for showing testing with this package

    For execution go to directory $projectRoot/{% project_name %}/
    and use `./manage.py test {% project_name %}.tests`

    You can also use `./manage.py test {% project_name %}.tests.models`
    """

    def test_model_is_model(self):
        """'model' and 'model' should equal"""
        self.assertEqual('model', 'model')
