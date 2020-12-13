import pandas as pd 
     
data = pd.read_csv("D:\ML project\Hackoff 3.0\indian_food.csv") 
   
data.dropna(inplace = True) 
   
data["ingredients"]= data["ingredients"].str.split(",") 
  
# print(data["ingredients"][0])

def intersection(lst1, lst2): 
  
    # Use of hybrid method 
    temp = set(lst2) 
    lst3 = [value for value in lst1 if value in temp] 
    return lst3 

score = []

def check(list):
  for i in data['ingredients']:
    len_intersected = len(intersection(i,list))
    len_of_product = len(i)
    diff = len_of_product - len_intersected
    score.append(diff)

index_list = []
def iter(var):
  for i in range(len(score)):
    if score[i] == var:
      index_list.append(i)

check(['Gram flour', 'ghee', 'sugar'])

iter(0)
iter(1)
iter(2)
iter(3)
iter(4)

# print(index_list)

print(data['name'][index_list[0]])
print(data['name'][index_list[1]])
print(data['name'][index_list[2]])