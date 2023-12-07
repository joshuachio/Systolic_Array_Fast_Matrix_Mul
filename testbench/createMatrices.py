import numpy as np

def createMatrices(num_matrices, num_rows):
    curr_matrix = None
    for i in range(num_matrices):
        new_matrix = np.random.randint(low=0, high=2**4, size=(num_rows, 4))
        if (curr_matrix is None):
            curr_matrix = new_matrix
        else:
            curr_matrix = np.matmul(curr_matrix, new_matrix)
        np.savetxt("matrices/matrix" + str(i) + ".txt", new_matrix, fmt="%d")
    np.savetxt("matrices/result.txt", curr_matrix, fmt="%d")

if __name__ == "__main__":
    createMatrices(2, 4)



