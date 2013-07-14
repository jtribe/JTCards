Cards
=====

Add controllers and manage them as a stack of cards.

The default layout and interaction behaviour is like Passbook.

[Check out the demo video:](http://youtu.be/81RvFKFfCUk)

How to use
==========

Check out the Examples in the project.

Here is a simple sample of how you add two controllers to the card controller.'


    - (BOOL)application:(UIApplication *)application 
            didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
      // create an array of controllers
      NSArray *cards = @[[[FirstViewController alloc] init], [[SecondViewController alloc] init]];
      // craete card contoller with array of controllers
      JTCardsViewController *controller = [[JTCardsViewController alloc] initWithCards:cards];
      
      self.window.rootViewController = controller;
      return YES;
    }


Adding as a child controller
==============

When you add a JTCardsViewController to another View Controller as a child then a container view to add the cards controller view to

      JTCardsViewController *cardsController = [[JTCardsViewController alloc] initWithCards:cards];
      [self.cardsController willMoveToParentViewController:self];
      [self addChildViewController:cardsController];
      // best to add to a container view 
      [self.containerView addSubview:cardsController.view];
      [cardsController didMoveToParentViewController:self];

This will allow you to cover only a part of the screen with the cards. Great if you need space for some labels above.

Be carefull with autolayout in your view hierarchy. If you add cardsController.view it may layout in a way that is unexpected.
