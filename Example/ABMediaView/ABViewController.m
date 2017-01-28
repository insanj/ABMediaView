//
//  ABViewController.m
//  ABMediaView
//
//  Created by Andrew Boryk on 01/04/2017.
//  Copyright (c) 2017 Andrew Boryk. All rights reserved.
//

#import "ABViewController.h"

@interface ABViewController ()

@end

@implementation ABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Sets functionality for this demonstration, visit the function to see different functionality
    [self initializeSettingsForMediaView:self.mediaView];
    
    // Setting which determines whether mediaView should pop up and display in full screen mode
    [self.mediaView setShouldDisplayFullscreen: YES];
    
    // Adjust the size ratio for the minimized view of the fullscreen popup. By default, the minimized view is ABMediaViewRatioPresetLandscape
    self.mediaView.minimizedAspectRatio = ABMediaViewRatioPresetLandscape;
    
    // Adjust the ratio of the screen that the width of the minimized view will stretch across. The default value for this is 0.5
    self.mediaView.minimizedWidthRatio = 1.0f;
    
    // Add space to the bottom of the mediaView when it is minimized. By default, there is 12px of space. More can be added if it is desired to reserve space on the bottom for a UITabbar, UIToolbar, or other content.
    [self.mediaView setBottomBuffer:0.0f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Gifs can be displayed in ABMediaView, where the gif can be downloaded from the internet
    // [self.mediaView setGifURL:@"http://static1.squarespace.com/static/552a5cc4e4b059a56a050501/565f6b57e4b0d9b44ab87107/566024f5e4b0354e5b79dd24/1449141991793/NYCGifathon12.gif"];
    
    // Gifs can also be displayed via NSData
    // NSData *gifData = ...;
    // [self.mediaView setGifData:gifData];
    
    // Set the url for the video that will be shown in the mediaView, it will download it and set it to the view. In addition, set the URL of the thumbnail for the video.
    //[self.mediaView setVideoURL:@"http://clips.vorwaerts-gmbh.de/VfE_html5.mp4" withThumbnailURL:@"http://camendesign.com/code/video_for_everybody/poster.jpg"];
    
    // Set the url for the audio that will be shown in the mediaView, it will download it and set it to the view. In addition, set the URL of the thumbnail for the video.
    [self.mediaView setAudioURL:@"http://narwakk.free.fr/musiques/Bob/Bob%20Marley%20-%20Roots,%20Rock,%20Reggae.mp3" withThumbnailURL:@"http://camendesign.com/code/video_for_everybody/poster.jpg"];
    
    // You can also set the video URL, download the video, and set a thumnail image that doesn't need to be downloaded
    // [self.mediaView setVideoURL:@"www.video.com/urlHere" withThumbnailImage:thumnailImage];
    
    // BONUS FUNCTIONALITY: If you want, you can also set a Gif as the thumnail, either by URL or NSData.
    // [self.mediaView setVideoURL:@"www.video.com/urlHere" withThumbnailGifURL:@"www.gif.com/urlHere"];
    // NSData *gifData = ...;
    // [self.mediaView setVideoURL:@"www.video.com/urlHere" withThumbnailGifData:gifData];
    
    // Rect that specifies where the mediaView's frame will originate from when presenting, and needs to be converted into its position in the mainWindow
//    self.mediaView.originRect = self.mediaView.frame;
    
    // If the frame of the mediaView is dynamic, and you would like it to present from the origin frame, then you can ensure this by setting the 'presentFromOriginRect' property to true. After this is set to true, there is no need to set the 'originRect' or 'originRectConverted' properties
    self.mediaView.presentFromOriginRect = YES;
    
    // This functionality toggles whether mediaViews with videos associated with them should autoPlay after presentation
    self.mediaView.autoPlayAfterPresentation = YES;
    
}

- (IBAction)showMediaViewAction:(id)sender {
    
    ABMediaView *mediaView = [[ABMediaView alloc] initWithFrame:self.view.frame];

    // Sets functionality for this demonstration, visit the function to see different functionality
    [self initializeSettingsForMediaView:mediaView];
    
    // Toggle hiding the close button, that way it does not show up in fullscreen mediaView. This functionality is only allowed if isMinimizable is enabled.
    [mediaView hideCloseButton:YES];
    
    // Set the url for the video that will be shown in the mediaView, it will download it and set it to the view. In addition, set the URL of the thumbnail for the video.
    [mediaView setVideoURL:@"http://clips.vorwaerts-gmbh.de/VfE_html5.mp4" withThumbnailURL:@"http://camendesign.com/code/video_for_everybody/poster.jpg"];
    
    // Present the mediaView, dismiss any other mediaView that is showing
    [[ABMediaView sharedManager] presentMediaView:mediaView];
}

- (void) initializeSettingsForMediaView: (ABMediaView *) mediaView {
    mediaView.delegate = self;
    
    mediaView.backgroundColor = [UIColor blackColor];
    
    // Changing the theme color changes the color of the play indicator as well as the progress track
    [mediaView setThemeColor:[UIColor redColor]];
    
    // Enable progress track to show at the bottom of the view
    [mediaView setShowTrack:YES];
    
    // Allow video to loop once reaching the end
    [mediaView setAllowLooping:YES];
    
    // Allows toggling for funtionality which would show remaining time instead of total time on the right label on the track
    [mediaView setShowRemainingTime:YES];
    
    // Allows toggling for functionality which would allow the mediaView to be swiped away to the bottom right corner, and allows the user to interact with the underlying interface while the mediaView sits there. Video continues to play if already playing, and the user can swipe right to dismiss the minimized view.
    [mediaView setCanMinimize: YES];
    
    /// Change the font for the labels on the track
    [mediaView setTrackFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:12.0f]];
    
    // Setting the contentMode to aspectFit will set the videoGravity to aspect as well
    mediaView.contentMode = UIViewContentModeScaleAspectFit;
    
    // If you desire to have the image to fill the view, however you would like the videoGravity to be aspect fit, then you can implement this functionality
    //    self.mediaView.contentMode = UIViewContentModeScaleAspectFill;
    //    [self.mediaView changeVideoToAspectFit: YES];
    
    // If the imageview is not in a reusable cell, and you wish that the image not disappear for a split second when reloaded, then you can enable this functionality
    mediaView.imageViewNotReused = YES;
}

#pragma mark - TransitionCoordinator

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Executes before and after rotation, that way any ABMediaViews can adjust their frames for the new size. Is especially helpful when users are watching landscape videos and rotate their devices between portrait and landscape.
    
    [coordinator animateAlongsideTransition:^(id  _Nonnull context) {
        
        // Notifies the ABMediaView that the device is about to rotate
        [[NSNotificationCenter defaultCenter] postNotificationName:ABMediaViewWillRotateNotification object:nil];
        
    } completion:^(id  _Nonnull context) {
        
        // Change origin rect because the screen has rotated
//        self.mediaView.originRect = self.mediaView.frame;
        
        // Notifies the ABMediaView that the device just finished rotating
        [[NSNotificationCenter defaultCenter] postNotificationName:ABMediaViewDidRotateNotification object:nil];
    }];
}

#pragma mark - ABMediaView Delegate

- (void) mediaView:(ABMediaView *)mediaView didChangeOffset:(float)offsetPercentage {
    NSLog(@"MediaView offset changed: %f", offsetPercentage);
}

- (void) mediaViewDidPlayVideo: (ABMediaView *) mediaView {
    NSLog(@"MediaView did play video");
}

- (void) mediaViewDidPauseVideo:(ABMediaView *)mediaView {
    NSLog(@"MediaView did pause video");
}

- (void) mediaViewWillPresent:(ABMediaView *)mediaView {
    NSLog(@"MediaView will present");
}

- (void) mediaViewDidPresent:(ABMediaView *)mediaView {
    NSLog(@"MediaView will present");
}

- (void) mediaViewWillDismiss:(ABMediaView *)mediaView {
    NSLog(@"MediaView will dismiss");
}

- (void) mediaViewDidDismiss:(ABMediaView *)mediaView {
    NSLog(@"MediaView did dismiss");
}

- (void) mediaView:(ABMediaView *)mediaView didDownloadImage:(UIImage *)image {
    NSLog(@"Image: %@", image);
}

- (void) mediaView:(ABMediaView *)mediaView didDownloadVideo:(NSString *)video {
    NSLog(@"Video path: %@", video);
}

- (void) mediaView:(ABMediaView *)mediaView didDownloadGif:(UIImage *)gif {
    NSLog(@"Gif: %@", gif);
}






@end
