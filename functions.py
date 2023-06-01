

def get_unique_list_f(lst):
    lst = input()
    result = set(lst)
    return(result)





def count_case_f(string):
    str={'Upper case count' :0, 'Lower case count':0}
    for i in string:
        if i.isupper():
           str['Upper case count']+=1
        elif i.islower():
           str['Lower case count']+=1
        else:
           pass
    return (str)
    
    
    
def remove_punctuation_f(sentence):
   for character in string.punctuation:
        sentence = sentence.replace(character, '')
   return sentence



def word_count_f(sentence):
    sentence = len(sentence.split())
    return sentence


    