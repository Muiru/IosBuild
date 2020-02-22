import Felgo 3.0
import QtQuick 2.0
import "pages"
import "model"
import "logic"

App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    onInitTheme: {
         // Set the status bar style to white (light style)
         Theme.colors.statusBarStyle = Theme.colors.statusBarStyleBlack

         // Set the navigation bar background to blue
         Theme.navigationBar.backgroundColor = "#A6039BE5"
        Theme.listItem.indent = dp(15)
         Theme.navigationBar.titleColor = "#0510b6"
         Theme.navigationBar.dividerColor = "#FF4527AO"

         // Set the background color, which is used as background color of pages
         Theme.colors.backgroundColor = "#FF4DD0E1"

         // Set the global text color to white
         Theme.colors.textColor = "#0510b6"
       }

    Logic{
        id:logic
    }

    DataModel{
        id:dataModel
        dispatcher: logic
    }

   Navigation{
       id:mainNavigation
       enabled: dataModel.userLoggedIn
       signal update

       NavigationItem{
           title: qsTr("Employee")
           icon: IconType.users

           NavigationStack{
               splitView: tablet

               initialPage: WorkersPage{
               onDataEnter: update()
               }
           }
       }
       NavigationItem{
           title:qsTr("Stock")
           icon: IconType.bank

           NavigationStack{
               splitView: tablet
               initialPage:Material{
               id:mat
               }
           }
       }

       NavigationItem{
           title: qsTr("Summary")
           icon: IconType.foursquare

           NavigationStack{
               id:sum
             initialPage: Summary{
             onLogoutClicked:{
                 logic.logout()
                 mainNavigation.currentIndex = 0
                 mainNavigation.currentNavigationItem.navigationStack.popAllExceptFirst()
             }
             }
           }
       }

      }

   LoginPage{
           z:1
           visible : opacity > 0
           enabled : visible
           opacity : dataModel.userLoggedIn ? 0 : 1

           Behavior on opacity {NumberAnimation {duration : 240}}
       }

}
