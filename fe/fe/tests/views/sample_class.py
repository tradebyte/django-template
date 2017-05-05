"""Sample class for code coverage"""

class SampleClass(object):
    """Sample class for code coverage"""

    def __init__(self):
        """Sets default value"""
        self.value_default = 'nonono'

    def return_value(self, value):
        """Just returns the given value"""
        self.value_default = value
        return value

    def no_ref(self):
        """Returns 'nonono'"""
        return self.value_default
