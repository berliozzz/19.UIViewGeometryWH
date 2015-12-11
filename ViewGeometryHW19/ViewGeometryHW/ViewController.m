//
//  ViewController.m
//  ViewGeometryHW
//
//  Created by Nikolay Berlioz on 11.10.15.
//  Copyright © 2015 Nikolay Berlioz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *board;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  create background with black color ---------------------------------------------------
    UIView *viewBackgroundBoard = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 320, 320)];
    viewBackgroundBoard.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:viewBackgroundBoard]; //viewBackgroundBoard это subView window
    viewBackgroundBoard.autoresizingMask =  UIViewAutoresizingFlexibleBottomMargin  | UIViewAutoresizingFlexibleLeftMargin |
                                            UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin; //при повороте размер не изменяется
    
    //  create main view with white color ----------------------------------------------------
    UIView *viewChessBoard = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 316, 316)];
    viewChessBoard.backgroundColor = [UIColor whiteColor];
    [viewBackgroundBoard addSubview:viewChessBoard]; //viewChessBoard it's subView viewBackgroundBoard

    CGRect rect = CGRectMake(2, 2, 39, 39);
    CGRect checkerOne = CGRectMake(2, 2, 19, 19);
    
    BOOL flagVar = YES; //если стоит YES, печатается сначала белая клетка
//    self.arrayView = [NSMutableArray array];
    
    for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            if (flagVar) //если YES, тогда просто пропускается длинна ячейки
            {
                flagVar = NO;   //флаг переводится в противоположное состояние
            }
            else        //если NO, печатается черная клетка
            {
                UIView *cellChessBoard = [[UIView alloc] initWithFrame:rect]; //создаю ячейку
                cellChessBoard.backgroundColor = [UIColor blackColor];
                [viewChessBoard addSubview:cellChessBoard]; //cellChessBoard it's subView viewChessBoard
                [cellChessBoard setTag:1];
//                [self.arrayView addObject:cellChessBoard];  //добавляем вьюшку в массив
            
                if (checkerOne.origin.y < 118) //если коодината у пешки выше 4-й клетки доски
                {
                    UIView *checkerBrown = [[UIView alloc] initWithFrame:checkerOne];
                    checkerBrown.backgroundColor = [UIColor brownColor];
                    [viewChessBoard addSubview:checkerBrown];
                    [checkerBrown setTag:2];
//                    [self.arrayCheckers addObject:checker];  //добавляем коричневую шашку в массив
                }
                else if (checkerOne.origin.y > 198) //если коодината у пешки ниже 5-й клетки доски
                {
                    UIView *checkerGray = [[UIView alloc] initWithFrame:checkerOne];
                    checkerGray.backgroundColor = [UIColor lightGrayColor];
                    [viewChessBoard addSubview:checkerGray];
                    [checkerGray setTag:3];
//                    [self.arrayCheckers addObject:checker];  //добавляем серую шашку в массив
                }
                flagVar = YES;
            }
            rect.origin.x += 39; //после одной интерации прибавляем 39 к оси х
            checkerOne.origin.x = rect.origin.x + 10; //все тоже что у черной клетки, но на 10 больше
            checkerOne.origin.y = rect.origin.y + 10; //все тоже что у черной клетки, но на 10 больше
        }
        flagVar = !flagVar;  // после печати одной строки ячеек переводим флаг в противоположное значение дабы новая строка начиналась с др цвета
        rect.origin.x = 2;  // по х выставляем начальные координаты
        rect.origin.y = rect.origin.y + 39; // по у выставляем начальные + 39 на каждой интерации цикла
        checkerOne.origin.x = rect.origin.x + 10; //все тоже что у черной клетки, но на 10 больше
        checkerOne.origin.y = rect.origin.y + 10; //все тоже что у черной клетки, но на 10 больше
    }
    self.board = viewChessBoard; //присваиваем свойству board вьюшку viewChessBoard, для видимости в коде
}

- (UIColor*) randomColor
{
    NSInteger oneOrTwo = arc4random() % 2;
    UIColor *color;
    
    if (oneOrTwo)
    {
       return color = [UIColor lightGrayColor];
    }
    else
    {
        return color = [UIColor brownColor];
    }
}

/*****************    в этом методе вносятся изменения при повороте экрана   *********************/
- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
         // do whatever
         
         switch (orientation)
         {
             case UIInterfaceOrientationLandscapeLeft:  //при повороте на лево цвет ячеек на доске становится синим и т.д.
                 for (UIView *view in self.board.subviews)
                 {
                     if (view.tag == 1)
                     {
                         view.backgroundColor = [UIColor blueColor]; //меняем цвет ячеек
                     }
                     else if (view.tag == 2 || view.tag == 3)
                     {
                         view.backgroundColor = [self randomColor];
                     }
                 }
                 
                 break;
             case UIInterfaceOrientationLandscapeRight:
                 for (UIView *view in self.board.subviews)
                 {
                     if (view.tag == 1)
                     {
                         view.backgroundColor = [UIColor redColor]; //меняем цвет ячеек
                     }
                     else if (view.tag == 2 || view.tag == 3)
                     {
                         view.backgroundColor = [self randomColor];
                     }
                 }
                 break;
             case UIInterfaceOrientationPortrait:
                 for (UIView *view in self.board.subviews)
                 {
                     if (view.tag == 1)
                     {
                         view.backgroundColor = [UIColor blackColor]; //меняем цвет ячеек
                     }
                     else if (view.tag == 2 || view.tag == 3)
                     {
                         view.backgroundColor = [self randomColor];
                     }
                 }
                 break;
             default:
                 for (UIView *view in self.board.subviews)
                 {
                     view.backgroundColor = [UIColor grayColor]; //меняем цвет ячеек
                 }
                 break;
         }
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {

     }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
