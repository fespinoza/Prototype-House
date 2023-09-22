#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"com.fespinozacast.code.prototypes.Prototype-House";

/// The "AccentColor" asset catalog color resource.
static NSString * const ACColorNameAccentColor AC_SWIFT_PRIVATE = @"AccentColor";

/// The "gymSample1" asset catalog image resource.
static NSString * const ACImageNameGymSample1 AC_SWIFT_PRIVATE = @"gymSample1";

/// The "gymSample2" asset catalog image resource.
static NSString * const ACImageNameGymSample2 AC_SWIFT_PRIVATE = @"gymSample2";

/// The "gymSample3" asset catalog image resource.
static NSString * const ACImageNameGymSample3 AC_SWIFT_PRIVATE = @"gymSample3";

/// The "iconBig" asset catalog image resource.
static NSString * const ACImageNameIconBig AC_SWIFT_PRIVATE = @"iconBig";

/// The "iconSmall" asset catalog image resource.
static NSString * const ACImageNameIconSmall AC_SWIFT_PRIVATE = @"iconSmall";

/// The "london" asset catalog image resource.
static NSString * const ACImageNameLondon AC_SWIFT_PRIVATE = @"london";

/// The "sampleAvatar" asset catalog image resource.
static NSString * const ACImageNameSampleAvatar AC_SWIFT_PRIVATE = @"sampleAvatar";

/// The "tedLassoBanner" asset catalog image resource.
static NSString * const ACImageNameTedLassoBanner AC_SWIFT_PRIVATE = @"tedLassoBanner";

/// The "tedLassoBanner2" asset catalog image resource.
static NSString * const ACImageNameTedLassoBanner2 AC_SWIFT_PRIVATE = @"tedLassoBanner2";

#undef AC_SWIFT_PRIVATE