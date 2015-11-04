# Traveling Salesman Problem 



![ellipse examle](https://github.com/SgtBlack/tspwithpso/blob/master/pictures/ellipse_example.png "Example for a ellipse data-set")

This problem involves finding the shortest closed tour (path) through a set of stops (cities).

# Problem Formulation
Formulate the travelling salesman problem for integer linear programming as follows:

- Generate all possible trips, meaning all distinct pairs of stops.
- Calculate the distance for each trip.
- The cost function to minimize is the sum of the trip distances for each trip in the tour.
- The decision variables are binary, and associated with each trip, where each 1 represents a trip that exists on the tour, and each 0 represents a trip that is not on the tour.
- To ensure that the tour includes every stop, include the linear constraint that each stop is on exactly two trips. This means one arrival and one departure from the stop.


![ellipse examle](https://github.com/SgtBlack/tspwithpso/blob/tsporiginal/pictures/tsponlytown.png "Dataset without optimal tour")


![ellipse examle](https://github.com/SgtBlack/tspwithpso/blob/tsporiginal/pictures/tspwithtour.png "Dataset with optimal tour")
