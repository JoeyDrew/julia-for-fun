### balance
### simply plots a bank statement balance over time


using DataFrames
using CSV
using Plots
using Printf  # import Printf module for sprintf function
plotly()

# load CSV data into a DataFrame
df = CSV.read("statement.csv", DataFrame)

dates = df[!, "Date"]
balances = df[!, "Balance"]

# format balance labels
function format_balance(x)
    return @sprintf("%.0f", x)
end

# function to format hover labels
function format_hover(date, balance)
    return "($(date), $(format_balance(balance)))"
end

# create a line plot
plot(dates, balances, xlabel = "Date", ylabel = "Balance", title = "Balance Over Time", legend = false, hoverlabel = (:both),
    yformatter = format_balance)

# customize hover labels
scatter!(dates, balances, markershape = :circle, markercolor = :black, label = "", hoverinfo = :text,
    hovertext = [format_hover(date, balance) for (date, balance) in zip(dates, balances)], show = true)

