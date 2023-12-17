import os
import shutil

def move_file(source_path, destination_path):
    """
    Move a file from the source path to the destination path.

    Parameters:
    source_path (str): The absolute path of the source file.
    destination_path (str): The absolute path of the destination directory.
    """
    # Check if the source file exists
    if not os.path.isfile(source_path):
        print(f"Error: The file {source_path} does not exist.")
        return

    # Check if the destination directory exists, if not, create it
    destination_dir = os.path.dirname(destination_path)
    if not os.path.exists(destination_dir):
        os.makedirs(destination_dir)

    # Move the file
    shutil.move(source_path, destination_path)
    print(f"File moved successfully from {source_path} to {destination_path}")

# Example usage
full_path_to_source = r'C:\Users\11097\AppData\Roaming\Typora\typora-user-images\image-20220728093414429.png'
full_path_to_destination = r'D:\Public\20230827_Hexo\blog\source\_posts\CH04_Rocking_the_Boat\10.png'
move_file(full_path_to_source, full_path_to_destination)