def is_reverse(string, string2):
    string = string.lower()
    string2 = string2.lower()
    znaki = [".", "!", "?", ":", ";", " "]
    for char in string:
        if char in znaki:
            string = string.replace(char, "")
    for char in string2:
        if char in znaki:
            string2 = string2.replace(char, "")

    if string == string2[::-1]:
        return True
    else:
        return False

import pytest
def test_is_reversed_base():
    assert is_reverse("кот", "ток") == True

def test_is_reversed_base2():
    assert is_reverse("не кот", "ток") == False
