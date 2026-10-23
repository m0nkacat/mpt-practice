import pytest
def is_reverse(string):


    znaki = [".", "!", "?", ":", ";", " "]
    for char in string:
        if char in znaki:
            string = string.replace(char, "")
    if string == string[::-1]:
        return True
    else:
        return False




def test_is_reversed_base():
    assert is_reverse("анна") == True

def test_is_reversed_base2():
    assert is_reverse("Ваня") == False

def test_is_reversed_base3():
    assert is_reverse("АнНа") == False

def test_is_reversed_base4():
    assert is_reverse("ан.на") == True

def test_is_reversed_base5():
    assert is_reverse("ан на") == True

def test_is_reversed_input(monkeypatch):
    monkeypatch.setattr("builtins.input", lambda _: input())



