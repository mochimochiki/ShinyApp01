#server.R ファイルのあるディレクトリが、Shiny アプリのワーキングディレクトリになる。
#server.R のコードの中で、shinyServer より前にあるコードは、Shiny アプリの起動時に一度だけ実行される。
#shinyServer の中に書かれたコードは、何度も実行されるため、アプリの速度を低下させる原因となる。
#ウィジェットの値を R の表現式に変換するには、switch 関数を使って下さい。

library(shiny)
library(maps)
library(mapproj)
source("helpers.R")

# Data Setup
counties <- readRDS("data/counties.rds")


shinyServer(function(input, output) {
  
  # ここにサーバーの処理を描く
  
  #plot
  output$map <- renderPlot({
    data <- switch(input$var,
                   "Percent White" = counties$white,
                   "Percent Black" = counties$black,
                   "Percent Hispanic" = counties$hispanic,
                   "Percent Asian" = counties$asian)
    color <- switch(input$var,
                    "Percent White" = "darkgreen",
                    "Percent Black" = "black",
                    "Percent Hispanic" = "darkorange",
                    "Percent Asian" = "darkviolet")
    min <- input$range[1]
    max <- input$range[2]
    title <- input$var
    
    percent_map(data, color = color, legend.title = title, max = max, min = min)
  })
  
  # output$xxxx←このxxxxはUI側で定義した要素
  # outputの出力要素はrenderxxxx関数の出力になる
  # renderTextだと文字列を出力する
  # output$text1 <- renderText({
  #   # input内にはUIで定義したWidget名が入っている。そのWidgetの値を使用できる。
  #   paste("You have selected", input$var)
  # })
  # 
  # output$text2 <- renderText({
  #   paste("You have chosen a range that goes from", input$range[1], "to", input$range[2])
  # })
})
