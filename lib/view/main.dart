import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timbumed/model/active_navbar_item.dart';
import 'package:timbumed/model/cart_item.dart';
import 'package:timbumed/model/product.dart';
import 'package:timbumed/view/cart.dart';
import 'package:timbumed/view/favourites.dart';
import 'package:timbumed/view/home.dart';
import 'package:timbumed/view/profile.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Product> _favoriteItems = [];
  final List<CartItem> _cartItems = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _toggleFavorite(Product product) {
    setState(() {
      if (_favoriteItems.contains(product)) {
        _favoriteItems.remove(product);
      } else {
        _favoriteItems.add(product);
      }
    });
  }

  bool _isFavorite(Product product) {
    return _favoriteItems.contains(product);
  }

  void _addToCart(Product product) {
    setState(() {
      var existingItem = _cartItems.firstWhere(
              (item) => item.product == product,
          orElse: () => CartItem(product: product));
      if (_cartItems.contains(existingItem)) {
        existingItem.quantity++;
      } else {
        _cartItems.add(existingItem);
      }
    });
  }

  void _removeFromCart(CartItem cartItem) {
    setState(() {
      _cartItems.remove(cartItem);
    });
  }

  void _updateQuantity(CartItem cartItem, int quantity) {
    setState(() {
      cartItem.quantity = quantity;
      if (cartItem.quantity <= 0) {
        _cartItems.remove(cartItem);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.bars, size: 15,), onPressed: () {}),
        title: Image.asset('assets/img/logo.png', height: 10,),
        actions: [
          IconButton(
              icon: const FaIcon(FontAwesomeIcons.cartShopping, size: 15,),
              onPressed: () {}),
          IconButton(
              icon: const FaIcon(FontAwesomeIcons.bell, size: 15,), onPressed: () {})
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Home(
            toggleFavorite: _toggleFavorite,
            isFavorite: _isFavorite,
            addToCart: _addToCart,
          ),
          Cart(
            cartItems: _cartItems,
            updateQuantity: _updateQuantity,
            removeFromCart: _removeFromCart,
          ),
          Home(
            toggleFavorite: _toggleFavorite,
            isFavorite: _isFavorite,
            addToCart: _addToCart,
          ),
          Favorites(
            favoriteItems: _favoriteItems,
            toggleFavorite: _toggleFavorite,
            isFavorite: _isFavorite,
            addToCart: _addToCart,
          ),
          const Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.house,
                  size: 15,
                  color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                ),
                RedDot(isSelected: _selectedIndex == 0),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.bagShopping,
                  size: 15,
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                ),
                RedDot(isSelected: _selectedIndex == 1),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.tableCellsLarge,
                  size: 15,
                  color: _selectedIndex == 2 ? Colors.black : Colors.grey,
                ),
                RedDot(isSelected: _selectedIndex == 2),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.heart,
                  size: 15,
                  color: _selectedIndex == 3 ? Colors.black : Colors.grey,
                ),
                RedDot(isSelected: _selectedIndex == 3),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.user,
                  size: 15,
                  color: _selectedIndex == 4 ? Colors.black : Colors.grey,
                ),
                RedDot(isSelected: _selectedIndex == 4),
              ],
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
