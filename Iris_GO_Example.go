// Name: Iris_GO_Example.go
// Date: September 18, 2018
// Original Source: Machine Learning with Go
// Description: Combined various small GO programs into this one 
// to analyze the Hello World Iris dataset. All errors are mine.
// Modified by: Patrick Hagan
//---------------------------------------------------------------------
import (
	"encoding/csv"
	"fmt"
	"io"
	"log"
	"os"
	"strconv"

	"github.com/gonum/floats"
	"github.com/gonum/stat"
	"github.com/kniren/gota/dataframe"
	"github.com/montanaflynn/stats"

	"github.com/gonum/plot"
	"github.com/gonum/plot/plotter"
	"github.com/gonum/plot/vg"
)

func main() {
 // Open the IRIS CVS file
 irisFile, err := os.Open("../data/iris.csv")
 if err != nil {
     log.Fatal(err)
 }
 defer irisFile.Close() 

 // Create a dataframe from the CVS file.
 // The types of the columns will be inferred.
 irisDF := dataframe.ReadCSV(irisFile)

 // As a sanity check, display the records to stdout.
 // Gota will format the dataframe for pretty printing.
 fmt.Printf(irisDF)

 // Create a filter for the dataframe.
 filter := dataframe.F{ 
	Colname: "species"
	Comparator: "=="
	Comparando: "Iris-versicolor"
 }

 // Filter the dataframe to see only the rows where
 // the iris species is "Iris-versicolor".
 versicolorDF := irisDF.Filter(filter)
 if versicolorDF.Err != nil {
	log.Fatal(versicolorDF.Err)
 }

 // Filter the dataframe again, but only select out the 
 // sepal_width and species columns
 versicolorDF = irisDF.Filter(filter).
 Select([]string{"sepal_width", "species"})

 // Filter the dataframe again, but only display  
 // the first three results
 versicolorDF = irisDF.Filter(filter).
 Select([]string{"sepal_width", "species"}).
 Subset([]int{0, 1, 2})

 // Get the float values from the "sepal_length" column 
 // because we want the measures for this variable
 sepal_Length := irisDF.Col("sepal_length").Float()

 // Calculate the Mean of the variable
 meanVal := stat.Mean(sepal_Length, nil)

 // Calculate the Mode of the variable
 modeVal, modeCount := stat.Mode(sepal_Length, nil)

 // Calculate the Median of the variable
 medianVal, err := stat.Median(sepal_Length)
 if err != nil {
	log.Fatal(err)
 }

 // Calculate the Min of the variable
 minVal := floats.Min(sepal_Length)

 // Calculate the Max of the variable
 maxVal := floats.Max(sepal_Length)

 // Calculate the Range of the variable
 rangeVal := maxVal - minVal

 // Calculate the Variance of the variable
 varianceVal := stat.Variance(sepal_Length, nil)

 // Calculate the Standard Deviation of the variable
 stdDevVal := stat.StdDev(sepal_Length, nil)

 // Sort the values
 floats.Argsort(sepal_Length, inds)

 // Get the Quantiles
 quant25 := stat.Quantile(0.25, stat.Empirical, sepal_Length, nil)
 quant50 := stat.Quantile(0.50, stat.Empirical, sepal_Length, nil)
 quant75 := stat.Quantile(0.75, stat.Empirical, sepal_Length, nil)

 // Output the results to standard out
 fmt.Printf("\n Sepal Length Summary Statistics: \n")
 fmt.Printf("    Mean Value: %0.2f\n", meanVal)
 fmt.Printf("    Mode Value: %0.2f\n", modeVal)
 fmt.Printf("    Mode Count: %0.2f\n", modeCount)
 fmt.Printf("  Median Value: %0.2f\n\n", medianVal)

 fmt.Printf("     Max Value: %0.2f\n\n", maxVal)
 fmt.Printf("     Min Value: %0.2f\n\n", minVal)
 fmt.Printf("   Range Value: %0.2f\n\n", rangeVal)
 fmt.Printf("Variance Value: %0.2f\n\n", varianceVal)
 fmt.Printf(" Std Dev Value: %0.2f\n\n", stdDevVal)
 fmt.Printf("   25 Quantile: %0.2f\n\n", quant25)
 fmt.Printf("   50 Quantile: %0.2f\n\n", quant50)
 fmt.Printf("   75 Quantile: %0.2f\n\n", quant75)

 // Create a histogram for each of the feature columns in the dataset
 for _, colName := range irisDF.Names() {
	// If the column is one of the feature columns, create histogram
	if colName != "species" {
		// Create a plotter.Values value and fill it with the 
		// values from the respective column of the dataframe
		v := make(plotter.Values, irisDF.Col(colName).Float())
		for i, floatVal := range irisDF.Col(colName).Float() {
			v[i] = floatVal
		}

		// Make a plot and set its title
		p, err := plot.New()
		if err != nil {
			log.Fatal(err)
		}
		
		p.Title.Text = fmt.Sprintf("Histogram of a %s", colName)
		
		// Create a histogram of our values drawn
		// from the standard normal.
		h, err := plotter.NewHist(v, 16)
		if err != nil {
			log.Fatal(err)
		}

		// Normalize the histogram
		h.normalize(1)
		
		// Add the histogram to the plot
		p.Add(h)

		// Save the plot to a PNG file
		if err := p.Save(4*vg.Inch, 4*vg.Inch, colName + "_hist.png"); err != nil {log.Fatal(err)}
		
		// Make a second plot and set its title and axis label
		p2, err := plot.New()
		if err != nil {
			log.Fatal(err)
		}
		
		p2.Title.Text = "Box Plots"
		p2.Y.Label.Text = "Values"

		// Create the box for our data
		w := vg.Points(50)

		// Create a box plot for each of the feature columns in the dataset
        for idx, colName := range irisDF.Names() {
			// If the column is one of the feature columns, create box plot
			if colName != "species" {
				// Create a plotter.Values value and fill it with the 
		        // values from the respective column of the dataframe
		        v2 := make(plotter.Values, irisDF.Nrow())
		        for i, floatVal := range irisDF.Col(colName).Float() {
			       v2[i] = floatVal
				}
				
				// Add the data to the plot
				b, err := plotter.NewBoxPlot(w, float64(idx), v2)
				if err != nil {
					log.Fatal(err)
				}
				
				// Add the histogram to the plot
		        p2.Add(h)

				// Set the x axis of the plot to nominal width
				// the given names for x=0, x=1, etc.
                p2.NominalX("sepal_length", "sepal_width", "petal_length", "petal_width")

        		// Save the plot to a PNG file
				if err := p2.Save(4*vg.Inch, 4*vg.Inch, colName + "_boxplots.png"); 
				  err != nil {log.Fatal(err)
				}
			}
		}
		
	}
 }
}


