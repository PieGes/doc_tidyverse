ggplot2
================
Pierre Gestraud
4 octobre 2016

### Example data

``` r
head(mpg)
```

    ## # A tibble: 6 × 11
    ##   manufacturer model displ  year   cyl      trans   drv   cty   hwy    fl
    ##          <chr> <chr> <dbl> <int> <int>      <chr> <chr> <int> <int> <chr>
    ## 1         audi    a4   1.8  1999     4   auto(l5)     f    18    29     p
    ## 2         audi    a4   1.8  1999     4 manual(m5)     f    21    29     p
    ## 3         audi    a4   2.0  2008     4 manual(m6)     f    20    31     p
    ## 4         audi    a4   2.0  2008     4   auto(av)     f    21    30     p
    ## 5         audi    a4   2.8  1999     6   auto(l5)     f    16    26     p
    ## 6         audi    a4   2.8  1999     6 manual(m5)     f    18    26     p
    ## # ... with 1 more variables: class <chr>

### Quickstart

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-2-1.png)

A plot has 3 main components:

-   data
-   a set of aesthetics
-   a set of layers (mainly geometries)

``` r
ggplot(mpg,   ## data
       aes(x = displ, y = hwy)) +  ## aesthetics
    geom_point() ## layer
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-3-1.png)

#### add geoms

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_line()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-4-1.png)

### aesthetics

-   `x`
-   `y`
-   `z`
-   `color`
-   `fill`
-   `size`
-   `text`
-   `shape`
-   `alpha`
-   `group`

Set color aesthetic to `manufacturer variable`

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = manufacturer)) + geom_point()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-5-1.png)

Set size aesthetic

``` r
ggplot(mpg, aes(x = displ, y = hwy, size = cyl)) + geom_point()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-6-1.png)

Alpha aesthetic

``` r
ggplot(mpg, aes(x = displ, y = hwy, size = cyl, color = class)) + geom_point(alpha = 0.5)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-7-1.png)

Set an aesthetic to a fixed value

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = "blue"))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-8-1.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(color = "blue")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-8-2.png)

Set an aestetic to a discrete numeric value

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = cyl)) + geom_point() ## gradient scale
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-9-1.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = factor(cyl))) + geom_point() ## discrete scale
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-9-2.png)

Aesthetics can be defined inside geom

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-10-1.png)

Aesthetics defined inside `ggplot` apply to all geom

``` r
ggplot(mpg, aes(x = class, y = hwy, color = class)) + geom_boxplot() + geom_point()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-11-1.png)

### a ggplot is an object

We can build a `ggplot` object in several steps

``` r
g <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() 
g ## or print(g)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-12-1.png)

``` r
g <- g + ggtitle("hwy vs displ")
g
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-12-2.png)

### geom

-   one variable
    -   continous
        -   `geom_density`
        -   `geom_histogram`
        -   `geom_freqpoly`
    -   discrete
        -   `geom_bar`
-   two variables
    -   continous X, continuous Y
        -   `geom_point`
        -   `geom_smooth`
        -   `geom_text`
    -   discrete X, continuous Y
        -   `geom_bar`
        -   `geom_boxplot`
        -   `geom_violin`
    -   bivariate distribution
        -   `geom_density2d`
        -   `geom_hex`
        -   `geom_bin2d`
    -   continuous function
        -   `geom_line`
        -   `geom_step`
-   three variables
    -   -   `geom_contour`
        -   `geom_tile`

#### data distributions

For histograms and densities only `x` is mandatory

``` r
ggplot(mpg, aes(x = hwy)) + geom_histogram()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-13-1.png)

``` r
ggplot(mpg, aes(x = hwy)) + geom_density()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-13-2.png)

``` r
ggplot(mpg, aes(x = hwy)) + geom_freqpoly()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-13-3.png)

Changing bins

``` r
ggplot(mpg, aes(x = hwy)) + geom_histogram(bins = 30)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-14-1.png)

``` r
ggplot(mpg, aes(x = hwy)) + geom_histogram(binwidth = 2)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-14-2.png)

Manually setting breaks

``` r
ggplot(mpg, aes(x = hwy)) + geom_histogram(breaks = c(10, 15, 20, 25, 30, 40, 50))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-15-1.png)

Add fill or color

``` r
ggplot(mpg, aes(x = hwy)) + geom_density(fill = "blue", color = "red")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-16-1.png)

``` r
ggplot(mpg, aes(x = hwy)) + geom_density(aes(fill = class))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-16-2.png)

#### Boxplots, violins, jitter

boxplots need `x` and `y` aestetics

``` r
ggplot(mpg, aes(x = class, y = hwy)) + geom_boxplot()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-17-1.png)

``` r
ggplot(mpg, aes(x = class, y = hwy, fill = class)) + geom_boxplot()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-17-2.png)

Add another variable as fill or color will separate boxplots

``` r
ggplot(mpg, aes(x = class, y = hwy, fill = trans)) + geom_boxplot()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-18-1.png)

Violin plots

``` r
ggplot(mpg, aes(x = class, y = hwy)) + geom_violin()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-19-1.png)

Jitters

``` r
ggplot(mpg, aes(x = class, y = hwy)) + geom_jitter()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-20-1.png)

``` r
## control width and height of jitter
ggplot(mpg, aes(x = class, y = hwy)) + geom_jitter(width = 0.5, height = 0)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-20-2.png)

``` r
ggplot(mpg, aes(x = class, y = hwy)) + geom_boxplot() + geom_jitter(width = 0.5, height = 0)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-21-1.png)

#### Bars

``` r
ggplot(mpg, aes(x = manufacturer)) + geom_bar()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-22-1.png)

Adding color

``` r
ggplot(mpg, aes(x = manufacturer, fill = class)) + geom_bar()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-23-1.png)

Changing bars positions

``` r
ggplot(mpg, aes(x = manufacturer, fill = class)) + geom_bar(position = "stack")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-24-1.png)

``` r
ggplot(mpg, aes(x = manufacturer, fill = class)) + geom_bar(position = "dodge")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-24-2.png)

``` r
ggplot(mpg, aes(x = manufacturer, fill = class)) + geom_bar(position = "fill")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-24-3.png)

Bar plot from count data

``` r
d <- data.frame(group = c("a", "b", "c"), n = c(10, 25 , 14))
```

``` r
## error
## ggplot(d, aes(x = group, y = n)) + geom_bar()
ggplot(d, aes(x = group, y = n)) + geom_bar(stat = "identity")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-26-1.png)

### add a smoother on the plot

Default smoother (loess if &lt;1000 obs, gam otherwise)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-27-1.png)

Linear model

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth(method = "lm")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-28-1.png)

Remove SE

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-29-1.png)

Smooth by group

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = class)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-30-1.png)

### Order of layers in object construction

Order of layers matters

``` r
ggplot(mpg, aes(x = class, y = hwy)) + geom_jitter(width = 0.5, height = 0) + geom_boxplot() 
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-31-1.png)

``` r
ggplot(mpg, aes(x = class, y = hwy)) + geom_boxplot() + geom_jitter(width = 0.5, height = 0) 
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-31-2.png)

### Scales

Scales are mainly controlled by `scale_*` functions. Their names are structured: \*scale\_'aestetic name'\_'type'\*

-   `scale_color_discrete`: discrete scale for color aestetic
-   `scale_fill_gradient`: continuous scale for fill aestetic

#### Discrete scales

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = class)) + geom_point() + scale_color_discrete(h = c(20, 150))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-32-1.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = class)) + geom_point() + scale_color_brewer(palette = "Set2")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-32-2.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = factor(cyl))) + geom_point() + scale_color_manual(values = c("blue", "black", "red", "pink"))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-32-3.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = factor(cyl))) + geom_point() + scale_color_manual(values = c('8' = "blue", '6' = "black", '4' = "red", '5' = "pink"))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-32-4.png)

#### gradient scales

``` r
ggplot(mpg, aes(x = displ, y = hwy, color = hwy)) + geom_point()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-33-1.png)

``` r
## 2 colors gradient
ggplot(mpg, aes(x = displ, y = hwy, color = hwy)) + geom_point() + scale_color_gradient(low = "green", high = "red")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-33-2.png)

``` r
## diverging color gradient, define low, mid and high colors
ggplot(mpg, aes(x = displ, y = hwy, color = hwy)) + geom_point() + scale_color_gradient2(low = "green", high = "red", mid = "black", midpoint = 25)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-33-3.png)

``` r
## n colors gradient
ggplot(mpg, aes(x = displ, y = hwy, color = hwy)) + geom_point() + scale_color_gradientn(colours = terrain.colors(10))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-33-4.png)

#### `xlim`/`ylim` vs `coord_cartesian`

-   `xlim`/`ylim` select data inside the range
-   coord\_cartesian zoom in the plot

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-34-1.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(c(2, 6))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-34-2.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + coord_cartesian(xlim = c(2, 6))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-34-3.png)

Warning: when computing densities or smoothers, the plot will completely change by using `xlim`/`ylim`

``` r
ggplot(mpg, aes(x = displ)) + geom_density(fill = "gray50")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-35-1.png)

``` r
ggplot(mpg, aes(x = displ)) + geom_density(fill = "gray50") + xlim(c(2, 3))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-35-2.png)

``` r
ggplot(mpg, aes(x = displ)) + geom_density(fill = "gray50") + coord_cartesian(xlim = c(2, 3))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-35-3.png)

#### axis transformation

-   flip axes

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + coord_flip()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-36-1.png)

-   polar coordinates

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + coord_polar()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-37-1.png)

-   reverse axis

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + scale_x_reverse()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-38-1.png)

-   log axis

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + scale_x_log10()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-39-1.png)

-   order of discrete scales

``` r
ggplot(mpg, aes(x = fl)) + geom_bar()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-40-1.png)

``` r
## change levels order 
mpg$fl2 <- factor(mpg$fl, levels = c("e", "p", "d", "r", "c"))
ggplot(mpg, aes(x = fl2)) + geom_bar()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-40-2.png)

``` r
## or use xlim
ggplot(mpg, aes(x = fl)) + geom_bar() + xlim(c("e", "p", "d", "r", "c"))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-40-3.png)

### Themes

Themes allow to have a set of graphics with the same style. Some are predefined `theme_default, theme_bw, them_minimal, theme_gray...`

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + theme_bw()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-41-1.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + theme_minimal()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-41-2.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + theme_dark()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-41-3.png)

We can customize some elements in themes (see <http://docs.ggplot2.org/dev/vignettes/themes.html> for details)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + theme(panel.background = element_rect(fill = "wheat"), axis.text = element_text(size = 20))
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-42-1.png)

### Faceting

Facetting allows to display plot separately according to discrete variables

Two functions for facetting: - `facet_wrap` - `facet_grid`

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + facet_wrap(~class)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-43-1.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + facet_grid(.~class)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-43-2.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + facet_grid(class~drv)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-43-3.png)

Controling facet\_wrap organisation

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + facet_wrap(~class, ncol = 2)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-44-1.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + facet_wrap(~class, scales = "free")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-44-2.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + facet_wrap(~class, scales = "free_x")
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-44-3.png)

All layers are faceted

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth() + facet_grid(~drv)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-45-1.png)

### add supplementary information on plot

#### add lines

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_hline(yintercept = 20)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-46-1.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_vline(xintercept = 4.5)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-46-2.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_abline(slope = -2, intercept = 35)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-46-3.png)

#### annotate

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + annotate(x = 4, y = 30, geom = "point", color = "red", size = 4)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-47-1.png)

``` r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + annotate(x = 4, y = 30, geom = "label", label = "annotation") 
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-47-2.png)

#### add data from external data.frame

``` r
d_annot <- data.frame(xpos = c(2, 5, 8), ypos = c(20, 25, 40), lab = c("l1", "l2", "l3"))
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_label(aes(x = xpos, y = ypos, label = lab), data = d_annot)
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-48-1.png)

### Programming with ggplot2

`ggplot2` use non standard evaluation (NSE). How to use variables in `aes`? `aes_string` allows standard evaluation.

``` r
my_var <- "displ"
ggplot(mpg, aes(x = my_var, y = hwy)) + geom_point()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-49-1.png)

``` r
ggplot(mpg, aes_string(x = my_var, y = "hwy")) + geom_point()
```

![](ggplot2_files/figure-markdown_github/unnamed-chunk-49-2.png)

### Interactivity

For interactive graphics see `ggvis` or `plotly` packages

``` r
require(ggvis)
ggvis(mpg, ~displ, ~hwy) %>% layer_points()
```

``` r
ggvis(mpg, ~displ, ~hwy) %>%  
    layer_smooths(span = input_slider(0.2, 1, value = 1), stroke := "blue") %>% 
    layer_points(size := input_slider(10, 200, value = 50))
```

``` r
require(plotly)
g <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
ggplotly(g)
```

### Extensions

-   `ggrepel`: smart geom\_text and geom\_label placement
-   `cowplot`: several plots on one page
-   `ggraph`: visualise graph
-   `ggmap`: plot data on a map
-   `factoextra`: visualise results of factorial analysis (PCA, CA, MCA, MFA, ...)
-   `ggbio`: visualise genomic data
-   `ggdendro`: visualise dendrograms and trees
-   `ggthemes`: additionnal themes

### Ressources

-   <http://docs.ggplot2.org>
-   rstudio cheatsheet <http://www.rstudio.com/wp-content/uploads/2015/04/ggplot2-cheatsheet.pdf>
-   ggplot2 book <https://github.com/hadley/ggplot2-book>
