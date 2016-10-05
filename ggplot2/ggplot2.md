# ggplot2
Pierre Gestraud  
4 octobre 2016  




### Example data


```r
head(msleep)
```

```
##                         name      genus  vore        order conservation
## 1                    Cheetah   Acinonyx carni    Carnivora           lc
## 2                 Owl monkey      Aotus  omni     Primates         <NA>
## 3            Mountain beaver Aplodontia herbi     Rodentia           nt
## 4 Greater short-tailed shrew    Blarina  omni Soricomorpha           lc
## 5                        Cow        Bos herbi Artiodactyla domesticated
## 6           Three-toed sloth   Bradypus herbi       Pilosa         <NA>
##   sleep_total sleep_rem sleep_cycle awake brainwt  bodywt
## 1        12.1        NA          NA  11.9      NA  50.000
## 2        17.0       1.8          NA   7.0 0.01550   0.480
## 3        14.4       2.4          NA   9.6      NA   1.350
## 4        14.9       2.3   0.1333333   9.1 0.00029   0.019
## 5         4.0       0.7   0.6666667  20.0 0.42300 600.000
## 6        14.4       2.2   0.7666667   9.6      NA   3.850
```

Create additionnal variable


```r
msleep$continent <- rep(c("Europe", "Africa", "Asia"), length.out = nrow(msleep))
```


### First plot


```r
qplot(sleep_total, sleep_rem, data = msleep)
```

![](ggplot2_files/figure-html/unnamed-chunk-3-1.png)<!-- -->


```r
qplot(sleep_total, sleep_rem, color = vore, data = msleep)
```

![](ggplot2_files/figure-html/unnamed-chunk-4-1.png)<!-- -->


```r
qplot(sleep_total, sleep_rem, size = bodywt, data = msleep)
```

![](ggplot2_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

### Advanced control 

main function: `ggplot` 

### Grammar of graphics

plot = data + geom + coordinate system

### Layer

a layer is composed of 

- data and aesthetic mapping,
- a statistical transformation,
- a geometric object
- and a position adjustement

### 


```r
ggplot(msleep,  ## data
       aes(x = sleep_total, y = sleep_rem)) + ## aesthetics
        geom_point() + ## layer
        ggtitle("REM vs total") ## additionnal elements
```

![](ggplot2_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

### a plot is an R object


```r
g <- ggplot(msleep, aes(x = sleep_total, y = sleep_cycle)) + geom_point() 
g ## or print(g)
```

![](ggplot2_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
g + ggtitle("cycle vs total")
```

![](ggplot2_files/figure-html/unnamed-chunk-7-2.png)<!-- -->


### geom

* one variable
    + continous
        - `geom_density`
        - `geom_histogram`
        - `geom_freqpoly`
    + discrete
        - `geom_bar`
* two variables
    + continous X, continuous Y
        - `geom_point`
        - `geom_smooth`
        - `geom_text`
    + discrete X, continuous Y
        - `geom_bar`
        - `geom_boxplot`
        - `geom_violin`
    + bivariate distribution
        - `geom_density2d`
        - `geom_hex`
        - `geom_bin2d`
    + continuous function
        - `geom_line`
        - `geom_step`
* three variables
    +
        - `geom_contour`
        - `geom_tile`


```r
ggplot(msleep, aes(x = vore, y = sleep_total)) + geom_boxplot()
```

![](ggplot2_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

```r
ggplot(msleep, aes(x = vore)) + geom_bar()
```

![](ggplot2_files/figure-html/unnamed-chunk-8-2.png)<!-- -->


### aesthetics

- `x`
- `y`
- `z` 
- `color`
- `fill`
- `size`
- `text`


```r
ggplot(msleep, aes(x = vore, y = sleep_rem, fill = vore)) + geom_boxplot()
```

![](ggplot2_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

```r
ggplot(msleep, aes(x = vore, y = sleep_rem, color = vore)) + geom_boxplot()
```

![](ggplot2_files/figure-html/unnamed-chunk-9-2.png)<!-- -->

```r
ggplot(msleep, aes(x = vore, y = sleep_rem, fill = continent)) + geom_boxplot()
```

![](ggplot2_files/figure-html/unnamed-chunk-9-3.png)<!-- -->


### add a smoother on the plot
Default smoother (loess if <1000 obs, gam otherwise)

```r
ggplot(msleep, aes(x = sleep_total, y = sleep_cycle)) + geom_point() + geom_smooth()
```

![](ggplot2_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

Linear model

```r
ggplot(msleep, aes(x = sleep_total, y = sleep_cycle)) + geom_point() + geom_smooth(method = "lm")
```

![](ggplot2_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

Remove SE

```r
ggplot(msleep, aes(x = sleep_total, y = sleep_cycle)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
```

![](ggplot2_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

### Order matters

```r
ggplot(msleep, aes(x = vore, y = sleep_total)) + geom_point() + geom_boxplot()
```

![](ggplot2_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

```r
ggplot(msleep, aes(x = vore, y = sleep_total)) + geom_boxplot() + geom_point()
```

![](ggplot2_files/figure-html/unnamed-chunk-13-2.png)<!-- -->

### Scales

- `xlim`/`ylim` vs `coord_cartesian`


```r
ggplot(msleep, aes(x = sleep_total, y = sleep_cycle)) + geom_point() + xlim(c(7.5, 17))
```

![](ggplot2_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

```r
ggplot(msleep, aes(x = sleep_total, y = sleep_cycle)) + geom_point() + coord_cartesian(xlim = c(7.5, 17))
```

![](ggplot2_files/figure-html/unnamed-chunk-14-2.png)<!-- -->

```r
ggplot(msleep, aes(x = sleep_total)) + geom_density(fill = "gray") 
```

![](ggplot2_files/figure-html/unnamed-chunk-14-3.png)<!-- -->

```r
ggplot(msleep, aes(x = sleep_total)) + geom_density(fill = "gray") + xlim(c(7.5, 17))
```

![](ggplot2_files/figure-html/unnamed-chunk-14-4.png)<!-- -->

```r
ggplot(msleep, aes(x = sleep_total)) + geom_density(fill = "gray") + coord_cartesian(xlim = c(7.5, 17))
```

![](ggplot2_files/figure-html/unnamed-chunk-14-5.png)<!-- -->



- axis transformation
- order
- color scales

### Themes

- default themes
- customize theme

### Faceting

Two functions for facetting:
- `facet_wrap`
- `facet_grid`


```r
ggplot(msleep, aes(x = sleep_total, y = sleep_rem)) + geom_point() + facet_wrap(~ vore)
```

![](ggplot2_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

```r
ggplot(msleep, aes(x = sleep_total, y = sleep_rem)) + geom_point() + facet_grid(continent ~ vore)
```

![](ggplot2_files/figure-html/unnamed-chunk-15-2.png)<!-- -->

Controling facet_wrap organisation


```r
ggplot(msleep, aes(x = sleep_total, y = sleep_rem)) + geom_point() + facet_wrap(~ vore, nrow = 1)
```

![](ggplot2_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

All layers are faceted

```r
ggplot(msleep, aes(x = sleep_total, y = sleep_rem)) + geom_point() + facet_wrap(~ vore) + geom_smooth(se = FALSE, method = "lm")
```

![](ggplot2_files/figure-html/unnamed-chunk-17-1.png)<!-- -->


- scales free
- labels

### add supplementary data

### Programming with ggplot2

`ggplot2` use non standard evaluation (NSE). How to use variables in `aes`? `aes_string` allows standard evaluation.


```r
var_x <- "sleep_total"
var_y <- "sleep_rem"
ggplot(msleep, aes(x = var_x, y = var_y)) + geom_point()
```

![](ggplot2_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

```r
ggplot(msleep, aes_string(x = var_x, y = var_y)) + geom_point()
```

![](ggplot2_files/figure-html/unnamed-chunk-18-2.png)<!-- -->


### Plot heatmap with ggplot2


```r
ggplot(msleep, aes(x = continent, y = vore, fill = sleep_total)) + geom_tile()
```

![](ggplot2_files/figure-html/unnamed-chunk-19-1.png)<!-- -->


```r
d <- as.data.frame(matrix(rnorm(100), ncol = 10))
colnames(d) <- paste0("s", 1:10)
d$gene <- paste0("g", 1:10)
require(tidyr)
dm <- gather(d, key = "sample", value = "exp", -gene) ## convert data to long format
ggplot(dm, aes(x = sample, y = gene, fill = exp)) + geom_tile()
```

![](ggplot2_files/figure-html/unnamed-chunk-20-1.png)<!-- -->


### Interactivity


```r
require(plotly)
g <- ggplot(msleep, aes(x = sleep_total, y = sleep_rem)) + geom_point()
ggplotly(g)
```

<!--html_preserve--><div id="htmlwidget-5158" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-5158">{"x":{"data":[{"x":[12.1,17,14.4,14.9,4,14.4,8.7,7,10.1,3,5.3,9.4,10,12.5,10.3,8.3,9.1,17.4,5.3,18,3.9,19.7,2.9,3.1,10.1,10.9,14.9,12.5,9.8,1.9,2.7,6.2,6.3,8,9.5,3.3,19.4,10.1,14.2,14.3,12.8,12.5,19.9,14.6,11,7.7,14.5,8.4,3.8,9.7,15.8,10.4,13.5,9.4,10.3,11,11.5,13.7,3.5,5.6,11.1,18.1,5.4,13,8.7,9.6,8.4,11.3,10.6,16.6,13.8,15.9,12.8,9.1,8.6,15.8,4.4,15.6,8.9,5.2,6.3,12.5,9.8],"y":[null,1.8,2.4,2.3,0.7,2.2,1.4,null,2.9,null,0.6,0.8,0.7,1.5,2.2,2,1.4,3.1,0.5,4.9,null,3.9,0.6,0.4,3.5,1.1,null,3.2,1.1,0.4,0.1,1.5,0.6,1.9,0.9,null,6.6,1.2,1.9,3.1,null,1.4,2,null,null,0.9,null,0.9,0.6,1.4,null,null,null,1,2.7,null,null,1.8,0.4,null,1.5,6.1,0.5,2.4,null,1.4,2.1,1.1,2.4,null,3.4,3,2,2.4,null,null,1,2.3,2.6,null,1.3,null,2.4],"text":["sleep_total: 12.1<br>sleep_rem: NA","sleep_total: 17<br>sleep_rem: 1.8","sleep_total: 14.4<br>sleep_rem: 2.4","sleep_total: 14.9<br>sleep_rem: 2.3","sleep_total: 4<br>sleep_rem: 0.7","sleep_total: 14.4<br>sleep_rem: 2.2","sleep_total: 8.7<br>sleep_rem: 1.4","sleep_total: 7<br>sleep_rem: NA","sleep_total: 10.1<br>sleep_rem: 2.9","sleep_total: 3<br>sleep_rem: NA","sleep_total: 5.3<br>sleep_rem: 0.6","sleep_total: 9.4<br>sleep_rem: 0.8","sleep_total: 10<br>sleep_rem: 0.7","sleep_total: 12.5<br>sleep_rem: 1.5","sleep_total: 10.3<br>sleep_rem: 2.2","sleep_total: 8.3<br>sleep_rem: 2","sleep_total: 9.1<br>sleep_rem: 1.4","sleep_total: 17.4<br>sleep_rem: 3.1","sleep_total: 5.3<br>sleep_rem: 0.5","sleep_total: 18<br>sleep_rem: 4.9","sleep_total: 3.9<br>sleep_rem: NA","sleep_total: 19.7<br>sleep_rem: 3.9","sleep_total: 2.9<br>sleep_rem: 0.6","sleep_total: 3.1<br>sleep_rem: 0.4","sleep_total: 10.1<br>sleep_rem: 3.5","sleep_total: 10.9<br>sleep_rem: 1.1","sleep_total: 14.9<br>sleep_rem: NA","sleep_total: 12.5<br>sleep_rem: 3.2","sleep_total: 9.8<br>sleep_rem: 1.1","sleep_total: 1.9<br>sleep_rem: 0.4","sleep_total: 2.7<br>sleep_rem: 0.1","sleep_total: 6.2<br>sleep_rem: 1.5","sleep_total: 6.3<br>sleep_rem: 0.6","sleep_total: 8<br>sleep_rem: 1.9","sleep_total: 9.5<br>sleep_rem: 0.9","sleep_total: 3.3<br>sleep_rem: NA","sleep_total: 19.4<br>sleep_rem: 6.6","sleep_total: 10.1<br>sleep_rem: 1.2","sleep_total: 14.2<br>sleep_rem: 1.9","sleep_total: 14.3<br>sleep_rem: 3.1","sleep_total: 12.8<br>sleep_rem: NA","sleep_total: 12.5<br>sleep_rem: 1.4","sleep_total: 19.9<br>sleep_rem: 2","sleep_total: 14.6<br>sleep_rem: NA","sleep_total: 11<br>sleep_rem: NA","sleep_total: 7.7<br>sleep_rem: 0.9","sleep_total: 14.5<br>sleep_rem: NA","sleep_total: 8.4<br>sleep_rem: 0.9","sleep_total: 3.8<br>sleep_rem: 0.6","sleep_total: 9.7<br>sleep_rem: 1.4","sleep_total: 15.8<br>sleep_rem: NA","sleep_total: 10.4<br>sleep_rem: NA","sleep_total: 13.5<br>sleep_rem: NA","sleep_total: 9.4<br>sleep_rem: 1","sleep_total: 10.3<br>sleep_rem: 2.7","sleep_total: 11<br>sleep_rem: NA","sleep_total: 11.5<br>sleep_rem: NA","sleep_total: 13.7<br>sleep_rem: 1.8","sleep_total: 3.5<br>sleep_rem: 0.4","sleep_total: 5.6<br>sleep_rem: NA","sleep_total: 11.1<br>sleep_rem: 1.5","sleep_total: 18.1<br>sleep_rem: 6.1","sleep_total: 5.4<br>sleep_rem: 0.5","sleep_total: 13<br>sleep_rem: 2.4","sleep_total: 8.7<br>sleep_rem: NA","sleep_total: 9.6<br>sleep_rem: 1.4","sleep_total: 8.4<br>sleep_rem: 2.1","sleep_total: 11.3<br>sleep_rem: 1.1","sleep_total: 10.6<br>sleep_rem: 2.4","sleep_total: 16.6<br>sleep_rem: NA","sleep_total: 13.8<br>sleep_rem: 3.4","sleep_total: 15.9<br>sleep_rem: 3","sleep_total: 12.8<br>sleep_rem: 2","sleep_total: 9.1<br>sleep_rem: 2.4","sleep_total: 8.6<br>sleep_rem: NA","sleep_total: 15.8<br>sleep_rem: NA","sleep_total: 4.4<br>sleep_rem: 1","sleep_total: 15.6<br>sleep_rem: 2.3","sleep_total: 8.9<br>sleep_rem: 2.6","sleep_total: 5.2<br>sleep_rem: NA","sleep_total: 6.3<br>sleep_rem: 1.3","sleep_total: 12.5<br>sleep_rem: NA","sleep_total: 9.8<br>sleep_rem: 2.4"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,0,0,1)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,0,0,1)"}},"showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","name":""}],"layout":{"margin":{"b":40.1826484018265,"l":31.4155251141553,"t":26.2283105022831,"r":7.30593607305936},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[1,20.8],"ticktext":["5","10","15","20"],"tickvals":[5,10,15,20],"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":"sleep_total","titlefont":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"hoverformat":".2f"},"yaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[-0.225,6.925],"ticktext":["0","2","4","6"],"tickvals":[0,2,4,6],"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":"sleep_rem","titlefont":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895}},"hovermode":"closest"},"source":"A","config":{"modeBarButtonsToRemove":["sendDataToCloud"]},"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
g <- ggplot(msleep, aes(x = sleep_total, y = sleep_rem, color = vore, text = name)) + geom_point()
ggplotly(g)
```

<!--html_preserve--><div id="htmlwidget-1416" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-1416">{"x":{"data":[{"x":[12.1,8.7,10.1,17.4,12.5,2.7,6.2,19.4,11,14.5,15.8,10.4,13.5,3.5,5.6,5.2,6.3,12.5,9.8],"y":[null,1.4,2.9,3.1,3.2,0.1,1.5,6.6,null,null,null,null,null,0.4,null,null,1.3,null,2.4],"text":["sleep_total: 12.1<br>sleep_rem: NA<br>vore: carni<br>Cheetah","sleep_total: 8.7<br>sleep_rem: 1.4<br>vore: carni<br>Northern fur seal","sleep_total: 10.1<br>sleep_rem: 2.9<br>vore: carni<br>Dog","sleep_total: 17.4<br>sleep_rem: 3.1<br>vore: carni<br>Long-nosed armadillo","sleep_total: 12.5<br>sleep_rem: 3.2<br>vore: carni<br>Domestic cat","sleep_total: 2.7<br>sleep_rem: 0.1<br>vore: carni<br>Pilot whale","sleep_total: 6.2<br>sleep_rem: 1.5<br>vore: carni<br>Gray seal","sleep_total: 19.4<br>sleep_rem: 6.6<br>vore: carni<br>Thick-tailed opposum","sleep_total: 11<br>sleep_rem: NA<br>vore: carni<br>Slow loris","sleep_total: 14.5<br>sleep_rem: NA<br>vore: carni<br>Northern grasshopper mouse","sleep_total: 15.8<br>sleep_rem: NA<br>vore: carni<br>Tiger","sleep_total: 10.4<br>sleep_rem: NA<br>vore: carni<br>Jaguar","sleep_total: 13.5<br>sleep_rem: NA<br>vore: carni<br>Lion","sleep_total: 3.5<br>sleep_rem: 0.4<br>vore: carni<br>Caspian seal","sleep_total: 5.6<br>sleep_rem: NA<br>vore: carni<br>Common porpoise","sleep_total: 5.2<br>sleep_rem: NA<br>vore: carni<br>Bottle-nosed dolphin","sleep_total: 6.3<br>sleep_rem: 1.3<br>vore: carni<br>Genet","sleep_total: 12.5<br>sleep_rem: NA<br>vore: carni<br>Arctic fox","sleep_total: 9.8<br>sleep_rem: 2.4<br>vore: carni<br>Red fox"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(248,118,109,1)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)"}},"name":"carni","legendgroup":"carni","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text"},{"x":[14.4,4,14.4,3,5.3,9.4,12.5,5.3,3.9,2.9,3.1,14.9,1.9,6.3,9.5,3.3,14.2,14.3,12.8,12.5,14.6,7.7,8.4,3.8,11.1,13,11.3,16.6,13.8,15.9,15.8,4.4],"y":[2.4,0.7,2.2,null,0.6,0.8,1.5,0.5,null,0.6,0.4,null,0.4,0.6,0.9,null,1.9,3.1,null,1.4,null,0.9,0.9,0.6,1.5,2.4,1.1,null,3.4,3,null,1],"text":["sleep_total: 14.4<br>sleep_rem: 2.4<br>vore: herbi<br>Mountain beaver","sleep_total: 4<br>sleep_rem: 0.7<br>vore: herbi<br>Cow","sleep_total: 14.4<br>sleep_rem: 2.2<br>vore: herbi<br>Three-toed sloth","sleep_total: 3<br>sleep_rem: NA<br>vore: herbi<br>Roe deer","sleep_total: 5.3<br>sleep_rem: 0.6<br>vore: herbi<br>Goat","sleep_total: 9.4<br>sleep_rem: 0.8<br>vore: herbi<br>Guinea pig","sleep_total: 12.5<br>sleep_rem: 1.5<br>vore: herbi<br>Chinchilla","sleep_total: 5.3<br>sleep_rem: 0.5<br>vore: herbi<br>Tree hyrax","sleep_total: 3.9<br>sleep_rem: NA<br>vore: herbi<br>Asian elephant","sleep_total: 2.9<br>sleep_rem: 0.6<br>vore: herbi<br>Horse","sleep_total: 3.1<br>sleep_rem: 0.4<br>vore: herbi<br>Donkey","sleep_total: 14.9<br>sleep_rem: NA<br>vore: herbi<br>Western american chipmunk","sleep_total: 1.9<br>sleep_rem: 0.4<br>vore: herbi<br>Giraffe","sleep_total: 6.3<br>sleep_rem: 0.6<br>vore: herbi<br>Gray hyrax","sleep_total: 9.5<br>sleep_rem: 0.9<br>vore: herbi<br>Mongoose lemur","sleep_total: 3.3<br>sleep_rem: NA<br>vore: herbi<br>African elephant","sleep_total: 14.2<br>sleep_rem: 1.9<br>vore: herbi<br>Mongolian gerbil","sleep_total: 14.3<br>sleep_rem: 3.1<br>vore: herbi<br>Golden hamster","sleep_total: 12.8<br>sleep_rem: NA<br>vore: herbi<br>Vole ","sleep_total: 12.5<br>sleep_rem: 1.4<br>vore: herbi<br>House mouse","sleep_total: 14.6<br>sleep_rem: NA<br>vore: herbi<br>Round-tailed muskrat","sleep_total: 7.7<br>sleep_rem: 0.9<br>vore: herbi<br>Degu","sleep_total: 8.4<br>sleep_rem: 0.9<br>vore: herbi<br>Rabbit","sleep_total: 3.8<br>sleep_rem: 0.6<br>vore: herbi<br>Sheep","sleep_total: 11.1<br>sleep_rem: 1.5<br>vore: herbi<br>Potoroo","sleep_total: 13<br>sleep_rem: 2.4<br>vore: herbi<br>Laboratory rat","sleep_total: 11.3<br>sleep_rem: 1.1<br>vore: herbi<br>Cotton rat","sleep_total: 16.6<br>sleep_rem: NA<br>vore: herbi<br>Arctic ground squirrel","sleep_total: 13.8<br>sleep_rem: 3.4<br>vore: herbi<br>Thirteen-lined ground squirrel","sleep_total: 15.9<br>sleep_rem: 3<br>vore: herbi<br>Golden-mantled ground squirrel","sleep_total: 15.8<br>sleep_rem: NA<br>vore: herbi<br>Eastern american chipmunk","sleep_total: 4.4<br>sleep_rem: 1<br>vore: herbi<br>Brazilian tapir"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(124,174,0,1)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(124,174,0,1)"}},"name":"herbi","legendgroup":"herbi","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text"},{"x":[19.7,19.9,18.1,8.4,8.6],"y":[3.9,2,6.1,2.1,null],"text":["sleep_total: 19.7<br>sleep_rem: 3.9<br>vore: insecti<br>Big brown bat","sleep_total: 19.9<br>sleep_rem: 2<br>vore: insecti<br>Little brown bat","sleep_total: 18.1<br>sleep_rem: 6.1<br>vore: insecti<br>Giant armadillo","sleep_total: 8.4<br>sleep_rem: 2.1<br>vore: insecti<br>Eastern american mole","sleep_total: 8.6<br>sleep_rem: NA<br>vore: insecti<br>Short-nosed echidna"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,191,196,1)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,191,196,1)"}},"name":"insecti","legendgroup":"insecti","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text"},{"x":[17,14.9,10,10.3,8.3,9.1,18,10.1,10.9,9.8,8,10.1,9.7,9.4,11,8.7,9.6,9.1,15.6,8.9],"y":[1.8,2.3,0.7,2.2,2,1.4,4.9,3.5,1.1,1.1,1.9,1.2,1.4,1,null,null,1.4,2.4,2.3,2.6],"text":["sleep_total: 17<br>sleep_rem: 1.8<br>vore: omni<br>Owl monkey","sleep_total: 14.9<br>sleep_rem: 2.3<br>vore: omni<br>Greater short-tailed shrew","sleep_total: 10<br>sleep_rem: 0.7<br>vore: omni<br>Grivet","sleep_total: 10.3<br>sleep_rem: 2.2<br>vore: omni<br>Star-nosed mole","sleep_total: 8.3<br>sleep_rem: 2<br>vore: omni<br>African giant pouched rat","sleep_total: 9.1<br>sleep_rem: 1.4<br>vore: omni<br>Lesser short-tailed shrew","sleep_total: 18<br>sleep_rem: 4.9<br>vore: omni<br>North American Opossum","sleep_total: 10.1<br>sleep_rem: 3.5<br>vore: omni<br>European hedgehog","sleep_total: 10.9<br>sleep_rem: 1.1<br>vore: omni<br>Patas monkey","sleep_total: 9.8<br>sleep_rem: 1.1<br>vore: omni<br>Galago","sleep_total: 8<br>sleep_rem: 1.9<br>vore: omni<br>Human","sleep_total: 10.1<br>sleep_rem: 1.2<br>vore: omni<br>Macaque","sleep_total: 9.7<br>sleep_rem: 1.4<br>vore: omni<br>Chimpanzee","sleep_total: 9.4<br>sleep_rem: 1<br>vore: omni<br>Baboon","sleep_total: 11<br>sleep_rem: NA<br>vore: omni<br>Potto","sleep_total: 8.7<br>sleep_rem: NA<br>vore: omni<br>African striped mouse","sleep_total: 9.6<br>sleep_rem: 1.4<br>vore: omni<br>Squirrel monkey","sleep_total: 9.1<br>sleep_rem: 2.4<br>vore: omni<br>Pig","sleep_total: 15.6<br>sleep_rem: 2.3<br>vore: omni<br>Tenrec","sleep_total: 8.9<br>sleep_rem: 2.6<br>vore: omni<br>Tree shrew"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(199,124,255,1)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(199,124,255,1)"}},"name":"omni","legendgroup":"omni","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text"},{"x":[7,10.3,11.5,13.7,5.4,10.6,12.8],"y":[null,2.7,null,1.8,0.5,2.4,2],"text":["sleep_total: 7<br>sleep_rem: NA<br>vore: NA<br>Vesper mouse","sleep_total: 10.3<br>sleep_rem: 2.7<br>vore: NA<br>Desert hedgehog","sleep_total: 11.5<br>sleep_rem: NA<br>vore: NA<br>Deer mouse","sleep_total: 13.7<br>sleep_rem: 1.8<br>vore: NA<br>Phalanger","sleep_total: 5.4<br>sleep_rem: 0.5<br>vore: NA<br>Rock hyrax","sleep_total: 10.6<br>sleep_rem: 2.4<br>vore: NA<br>Mole rat","sleep_total: 12.8<br>sleep_rem: 2<br>vore: NA<br>Musk shrew"],"key":null,"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(127,127,127,1)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(127,127,127,1)"}},"name":"NA","legendgroup":"NA","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text"}],"layout":{"margin":{"b":40.1826484018265,"l":31.4155251141553,"t":26.2283105022831,"r":7.30593607305936},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[1,20.8],"ticktext":["5","10","15","20"],"tickvals":[5,10,15,20],"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":"sleep_total","titlefont":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"hoverformat":".2f"},"yaxis":{"type":"linear","autorange":false,"tickmode":"array","range":[-0.225,6.925],"ticktext":["0","2","4","6"],"tickvals":[0,2,4,6],"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"domain":[0,1],"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":"sleep_rem","titlefont":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.913385826771654},"annotations":[{"text":"vore","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"top"}],"hovermode":"closest"},"source":"A","config":{"modeBarButtonsToRemove":["sendDataToCloud"]},"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


### Extensions

- `ggrepel`: smart geom_text and geom_label placement
- `cowplot`: several plots on one page
- `ggraph`: visualise graph
- `ggmap`: plot data on a map
- `factoextra`: visualise results of factorial analysis (PCA, CA, MCA, MFA, ...)
- `ggbio`: visualise genomic data
- `ggdendro`: visualise dendrograms and trees

### Ressources

- http://docs.ggplot2.org
- rstudio cheatsheet http://www.rstudio.com/wp-content/uploads/2015/04/ggplot2-cheatsheet.pdf
