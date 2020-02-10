import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(BoardsEdge());
/*Loads 'main' as a Widget, even the app itself is a Widget. '=>' AKA 'fat arrow' in Dart 
is the single line lambda function syntax for the language. Pretty cool.  */

class BoardsEdge extends StatelessWidget {
  // This is the root Widget (Class).
  @override
  Widget build(BuildContext context) {
    // 'build' is the equivalent of a constructor for a class (note its also a widget like everything)
    return MaterialApp(
        home: LoginPage(), // Sets the login page as the home page.
        theme: ThemeData(
            // TODO: primarySwatch: Colors.black **FIXME this is making the build break right now with a black inheritance issue from Colors.
            ));
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        // This is a 'Stack' type because it has multiple children elements (Image, and Column which in turn has many children itself)
        fit: StackFit
            .expand, // Note 'fit' here is a property of the body Stack making the image expand to fill the display.
        children: <Widget>[
          Image(
              image: AssetImage("assets/loginImage.jpg"),
              fit: BoxFit.cover,
              color: Colors
                  .black87, // The number here is the opacity (87% opaque to help get the layered look with the background image)
              colorBlendMode: BlendMode
                  .darken // Blends the background color with the background image.
              ),
          Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // For column, main axis alignment will always be vertically aligned (row = horizontal for main axis)
            children: <Widget>[
              Form(
                child: Theme(
                  // This theme is wrapping the entire Column child which displays all the text fields, allowing the forms to have their own speerate theme (brighter than the background)
                  data: ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.red,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                              color: Colors.grey[200], fontSize: 20.0))),
                  child: Container(
                    // This container is also wrapping the next column widget to enable padding (and whatver else we want for layout)
                    padding: const EdgeInsets.all(40.00),
                    child: Column(
                      // Entering column as a child here allows for multiple forms.
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Username",
                          ),
                          keyboardType: TextInputType
                              .emailAddress, // This is just telling it to pull up the right keyboard type for an email address
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top:
                                  40.0), // Creates padding between login button and forms
                        ),
                        // TODO: make the button check user credentials. Right now it just logs in no matter what
                        MaterialButton(
                          color: Colors.grey[200],
                          textColor: Colors.black,
                          child: Text("Login"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainMenuPage()),
                            );
                          },
                          splashColor: Colors
                              .blueAccent, //Creates the color splash when u press the button.
                        ),
                        MaterialButton(
                          color: Colors.grey[200],
                          textColor: Colors.black,
                          child: Text("New User"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateNewUser()),
                            );
                          },
                          // Doesn't do anything right now but will link to the create user page!
                          splashColor: Colors
                              .blueAccent, //Creates the color splash when u press the button.
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MainMenuPage extends StatefulWidget {
  /* Note every stateful Widget requires two classes to implement. This stateless immuatable one with the 'createState()' 
method creates a stateful insatnce of _MainMenuPageState which is implemented under MainMenuPage. */
  MainMenuPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainMenuPageState createState() =>
      _MainMenuPageState(); // The underscore prefix indicates this is a private class, see notes for more.
}

class _MainMenuPageState extends State<MainMenuPage> {
  int _selectedIndex = 0;
  // This index keeps track of the current item selected on the bottom NavBar.
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home', style: optionStyle),
    Text('Index 1: Sheets', style: optionStyle),
    Text('Index 3: Profile', style: optionStyle)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainMenuPage()),
        );
      }

      if (index == 1) {
        // TODO add a route for the sheets page here.
      }
      if (index == 2) {
        // TODO add a route for the profile page here.
      }
    });
  }

  // All the code from the beginning of the class to here is for the NavBar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const RaisedButton(
              onPressed:
                  null, // Null will be changed to link to the next screen. This is a good next thing to work on.
              child: Text(
                'Game Master',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const RaisedButton(
                onPressed: null,
                child: Text('Adventurer',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors
                            .black)) // Change the style of the button here. Might be abe to link this to a custom theme we create later.
                )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode),
            title: Text('Sheets'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow[600],
        onTap: _onItemTapped,
      ),
    );
  }
}

class CreateNewUser extends StatefulWidget {
  @override
  _CreateNewUserState createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Colors.black12,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Form(
            child: Theme(
              data: ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.red,
                  backgroundColor: Colors.black,
                  inputDecorationTheme: InputDecorationTheme(
                      labelStyle:
                          TextStyle(color: Colors.grey[200], fontSize: 20.0))),
              child: Container(
                padding: const EdgeInsets.all(40.00),
                child: Column(
                  // Entering column as a child here allows for multiple forms.
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "New Username",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email Address",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "New Password",
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    MaterialButton(
                      color: Colors.grey[200],
                      textColor: Colors.black,
                      child: Text("Create"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainMenuPage()),
                        );
                      },
                      splashColor: Colors
                          .blueAccent, //Creates the color splash when u press the button.
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
