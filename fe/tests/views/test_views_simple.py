"""Sample tests"""

from django.test import TestCase
from .sample_class import SampleClass


class AnimalTestCase(TestCase):
    """
    Simple test for showing testing with this package

    For execution go to directory $projectRoot/fe/ and use `./manage.py test fe.tests`
    You can also use `./manage.py test fe.tests.views`
    """

    def test_view_is_view(self):
        """'view' and 'view' should equal"""
        self.assertEqual('view', 'view')

    def test_sample(self):
        """'view' and 'view' should equal"""
        sample = SampleClass()

        self.assertEqual('view', sample.return_value('view'))
