import os
import re
import zipfile

""""

AWS CLI Command
aws s3 cp --recursive s3://{bucket_name} {target_folder}

"""

"""

Gets a list of all directories and subdirectories and stores them in a list

"""
def get_all_dir(path: str):
    temp = [f.path for f in os.scandir(path) if f.is_dir()]

    get_dir(temp)

    if(len(temp) == 0):
        return 1
    else:
        for p in temp:
            get_all_dir(p)
            
"""

Helper function for get all directories.

"""
def get_dir(paths: list):
    for path in paths:
        print(path)
        get_file_from_dir(path)

"""

Gets all file paths from given directory and sends it to filtering service

"""
def get_file_from_dir(path: str):
    files = [f.path for f in os.scandir(path) if f.is_file()]
    if(len(files) != 0):
        filter_files(files)

"""

Filters out duplicate images and takes the scaled image or the largest dimensions

"""
def filter_files(files: list):
    sent_file = False
    largest_file = {
        "path": '',
        "size": 0
    }
    for i in range(len(files)):
        sent_file = False
        temp = re.search("([-_][0-9]+x[0-9]+)+$", files[i])
        if(temp is None):
            temp = re.search("scaled", files[i])
            if(temp is None):
                sent_file = True 
                send_to_new_dir(files[i])
        else:
            try:
                s = files[i][temp.span()[0]+1:temp.span()[1]].split('x')

                temp_size = int(s[0])*int(s[1])
                if(temp_size > largest_file['size']):
                    largest_file['path'] = files[i]
                    largest_file['size'] = temp_size
            except:
                pass
    if(not sent_file):
        send_to_new_dir(largest_file['path'])

"""

Takes file paths for filtered images and sends them to category bins 

"""
def send_to_new_dir(path: str):
    global images
    global docs
    global other
    temp = path.split('.')[-1]

    if(temp in ['png', 'jpg', 'gif']):
        images.append(path)
    elif(temp in ['pdf', 'docx', 'html']):
        docs.append(path)
    elif(temp == 'jpeg'):
        temp = convert(path)
        os.rename(path,temp)
        images.append(temp)
    else:
        other.append(path) 

"""

Changes jpeg files to jpg

"""
def convert(path: str):
    return path.replace('jpeg','jpg')


"""

Gets all file paths in directory

"""
def get_files(dir: str):
    return [f.path for f in os.scandir(dir) if f.is_file()]


"""

Takes array of file paths and removes old path from image and zips the enclosing directory 

"""
def zip_files(original_file_paths: list[str], type: str):
    for i in range(len(original_file_paths)):
        try:
            temp = remove_dimensions(original_file_paths[i].split('\\')[-1])
            os.rename(original_file_paths[i],temp)
        except:
            with open('./failed/images.txt', 'a') as f:
                print(temp)
                f.write(original_file_paths[i]+'\n')   


"""

Checks if paths exist and if they do delete them

"""
def check_if_dir_exists():
    for path in ['docs', 'images', 'other', 'failed']:
        if(os.path.exists(path)):
            for file in os.scandir(path):
                if(file.is_file()):
                    os.remove(file)


"""

Removes dimensions from images file name

"""
def remove_dimensions(path: str):
    if('.jpeg' in path):
        path = convert(path)
    search = re.search('([-_][0-9]+x[0-9]+)+\.',path)
    if(search is not None):
        start, end = search.span()
        temp = path[:start]+'.'+path[end:]
        return temp
    return path\

"""

Breaks files into batches of 200 MB

"""
def batch_zipper(zip_name):
    size = 0
    files = get_files('.')
    with zipfile.ZipFile(zip_name,'w') as zip:
        while(size < 200_000_000):
            temp = files.pop()
            if('.py' not in temp and '.zip' not in temp):
                zip.write(temp, compress_type=zipfile.ZIP_DEFLATED)
                size += os.stat(temp).st_size
                os.remove(temp)
                print(size)
    zip.close()


"""

Driver Function

"""

if(__name__ == "__main__"):
    images = docs = other = []
    term = True
    i = 0
    while(term):
        try:
            batch_zipper('images'+str(i)+'.zip')
            i+=1
        except Exception as e:
            print(e)
            term = False
