from django.test import TestCase

class AnimalTestCase(TestCase):
    """
    Simple test for showing testing with this package
    
    For execution go to directory $projectRoot/fe/ and use `./manage.py test fe.tests`
    You can also use `./manage.py test fe.tests.views`
    """

    def test_view_is_view(self):
        """'view' and 'view' should equal"""
        self.assertEqual('view', 'view')
