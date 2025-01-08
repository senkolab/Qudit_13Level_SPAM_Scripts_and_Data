Each line entry in the textfile "Leakage_test_614nm_withshutter_10000_samples.txt" is a realization of the experiment.
The relevant data in each line are the two numbers in the square bracket of the first curly bracket. 
They represent the photon count collected by the PMT when the ion is first initialized and after waiting for 100 ms.

For example, in this line:
[{"0": [2, 1]}, null, null, 0, false, [], false, 0, [], null, 0, 1734575172.800094, 0, {}]

The relevant information is [1, 0], meaning the photon count when first initialized is 2 and after waiting for 100 ms is 1.