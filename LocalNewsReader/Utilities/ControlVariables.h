//
//  Header.h
//  HorizontalTables
//
//  Created by Felipe Laso on 8/19/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//


#define FEED_URL @"http://pipes.yahoo.com/pipes/pipe.run?_id=64739dffdbc6caf5dc3417839a6b8edc&_render=json"

#define HEADER_HEIGHT 55
#define FOOTER_HEIGHT 40


// iPhone CONSTANTS

#define kTableLength    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? 768 : 320


#define ARTICLE_CELL_X_ORIGIN_IPHONE 5

#define ARTICEL_CELL_Y_ORIGIN_IPHONE 5

#define ARTICLE_CELL_WIDTH_IPHONE 110

#define ARTICEL_CELL_HEIGHT_IPHONE 80

#define ARTICLE_TABLE_ROW_HEIGHT_IPHONE 115


//IPAD

#define ARTICLE_CELL_X_ORIGIN_IPAD 5

#define ARTICEL_CELL_Y_ORIGIN_IPAD 10

#define ARTICLE_CELL_WIDTH_IPAD 130

#define ARTICEL_CELL_HEIGHT_IPAD 100

#define ARTICLE_TABLE_ROW_HEIGHT_IPAD 135


// Width of the cells of the embedded table view (after rotation, which means it controls the rowHeight property)
#define kCellWidth                                  120
// Height of the cells of the embedded table view (after rotation, which would be the table's width)
#define kCellHeight                                 90


#define kCellWidth_iPad                                 160
// Height of the cells of the embedded table view (after rotation, which would be the table's width)
#define kCellHeight_iPad                                100



// Padding for the Cell containing the article image and title
#define kArticleCellVerticalInnerPadding            5
#define kArticleCellHorizontalInnerPadding          5

// Padding for the title label in an article's cell
#define kArticleTitleLabelPadding                   4

// Vertical padding for the embedded table view within the row
#define kRowVerticalPadding                         0
// Horizontal padding for the embedded table view within the row
#define kRowHorizontalPadding                       0


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// iPad CONSTANTS
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Width (or length before rotation) of the table view embedded within another table view's row
#define kTableLength_iPad                               768

// Height for the Headlines section of the main (vertical) table view
#define kHeadlinesSectionHeight_iPad                    65

// Height for regular sections in the main table view
#define kRegularSectionHeight_iPad                      36

// Width of the cells of the embedded table view (after rotation, which means it controls the rowHeight property)


// Padding for the Cell containing the article image and title
#define kArticleCellVerticalInnerPadding_iPad           10
#define kArticleCellHorizontalInnerPadding_iPad         10

// Vertical padding for the embedded table view within the row
#define kRowVerticalPadding_iPad                        0
// Horizontal padding for the embedded table view within the row
#define kRowHorizontalPadding_iPad                      0


#define COLOR_BLUE_1 @"1693A5"
#define COLOR_DIRTY_GREEN @"388E82"
#define COLOR_LIGHT_BLUE @"A6D0E5"