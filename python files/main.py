import numpy
from firebase import firebase
import pandas as pd

data = pd.read_csv("indian_food.csv")

data.dropna(inplace=True)

data["ingredients"] = data["ingredients"].str.split(",")

firebase = firebase.FirebaseApplication("https://hackoff20-1f576-default-rtdb.firebaseio.com/")
'''data={
    "Most matched":data['name'][index_list[0]] ,
    "Recipe1":data['name'][index_list[1]],
    "Recipe2":data['name'][index_list[2]],

}'''

ingredients={
    "Ingredient 1":"Milk" ,
    "Ingredient 2":"Ghee",
    "Ingredient 3":"Sugar",
}
'''final =firebase.put("ratatouille-dbe8f-default-rtdb/Ingredients/-MOPgNFVzNzHFls1DAAn",'Ingredient 1','Milk')
final =firebase.put("ratatouille-dbe8f-default-rtdb/Ingredients/-MOPgNFVzNzHFls1DAAn",'Ingredient 2','Butter')
final =firebase.put("ratatouille-dbe8f-default-rtdb/Ingredients/-MOPgNFVzNzHFls1DAAn",'Ingredient 3','Curd')'''

result =firebase.get("ingredient",'')
k=list(result.values())
l=[]
l =k[0]
print(l)


def intersection(lst1, lst2):
    # Use of hybrid method
    temp = set(lst2)
    lst3 = [value for value in lst1 if value in temp]
    return lst3


score = []


def check(list):
    for i in data['ingredients']:
        len_intersected = len(intersection(i, list))
        len_of_product = len(i)
        diff = len_of_product - len_intersected
        score.append(diff)


index_list = []


def iter(var):
    for i in range(len(score)):
        if score[i] == var:
            index_list.append(i)


check(l)

iter(0)
iter(1)
iter(2)
iter(3)
iter(4)
print(data['prep_time'][index_list[0]])
print(data['name'][index_list[0]])
print(data['name'][index_list[1]])
print(data['name'][index_list[2]])
recipe ={
    "0":data['name'][index_list[0]],
    "1":data['name'][index_list[1]],
    "2":data['name'][index_list[2]],
    "3":data['name'][index_list[3]],
}


extra = {
    'name': data['name'][index_list[0]],
    'Ingredients': data['ingredients'][index_list[0]],

}

final1 =firebase.put("recipe",'list',recipe)





print(final1)






