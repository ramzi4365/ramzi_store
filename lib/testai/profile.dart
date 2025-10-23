// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   bool notificationsEnabled = true;
//
//   // Mock user data
//   final String userName = "John Doe";
//   final String userEmail = "john.doe@example.com";
//   final String userPhone = "+1 234 567 8900";
//   final String userImage = "https://via.placeholder.com/150x150/2C3E50/FFFFFF?text=JD";
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           'Profile',
//           style: TextStyle(
//             color: theme.primaryColor,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: theme.primaryColor, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit_outlined, color: theme.primaryColor, size: 22),
//             onPressed: () {
//               // Edit profile action
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Profile Header Section
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   // Profile Picture
//                   Stack(
//                     alignment: Alignment.bottomRight,
//                     children: [
//                       Container(
//                         width: 120,
//                         height: 120,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: theme.primaryColor,
//                             width: 3,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10,
//                               offset: const Offset(0, 5),
//                             ),
//                           ],
//                         ),
//                         child: ClipOval(
//                           child: Image.network(
//                             userImage,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 color: theme.primaryColor,
//                                 child: const Icon(
//                                   Icons.person,
//                                   size: 60,
//                                   color: Colors.white,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: theme.primaryColor,
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: Colors.white,
//                             width: 2,
//                           ),
//                         ),
//                         child: const Icon(
//                           Icons.camera_alt,
//                           size: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // User Name
//                   Text(
//                     userName,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   // User Email
//                   Text(
//                     userEmail,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // Menu Items
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.03),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // Personal Information
//                   _buildMenuItem(
//                     icon: Icons.person_outline,
//                     title: 'Personal Information',
//                     subtitle: 'Update your details',
//                     onTap: () {
//                       // Navigate to personal info
//                     },
//                   ),
//                   _buildDivider(),
//
//                   // Notifications Toggle
//                   _buildNotificationItem(theme),
//                   _buildDivider(),
//
//                   // Orders History
//                   _buildMenuItem(
//                     icon: Icons.shopping_bag_outlined,
//                     title: 'Order History',
//                     subtitle: 'View your past orders',
//                     onTap: () {
//                       // Navigate to orders
//                     },
//                   ),
//                   _buildDivider(),
//
//                   // Payment Methods
//                   _buildMenuItem(
//                     icon: Icons.payment_outlined,
//                     title: 'Payment Methods',
//                     subtitle: 'Manage your cards',
//                     onTap: () {
//                       // Navigate to payment methods
//                     },
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // Support Section
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.03),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   // Contact Us
//                   _buildMenuItem(
//                     icon: Icons.headset_mic_outlined,
//                     title: 'Contact Us',
//                     subtitle: 'Get help & support',
//                     onTap: () {
//                       _showContactDialog(context);
//                     },
//                   ),
//                   _buildDivider(),
//
//                   // About Us
//                   _buildMenuItem(
//                     icon: Icons.info_outline,
//                     title: 'About Us',
//                     subtitle: 'Learn more about us',
//                     onTap: () {
//                       _showAboutDialog(context);
//                     },
//                   ),
//                   _buildDivider(),
//
//                   // Privacy Policy
//                   _buildMenuItem(
//                     icon: Icons.privacy_tip_outlined,
//                     title: 'Privacy Policy',
//                     subtitle: 'How we protect your data',
//                     onTap: () {
//                       // Navigate to privacy policy
//                     },
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // Logout Button
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _showLogoutDialog(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red[400],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.logout, color: Colors.white, size: 20),
//                     const SizedBox(width: 8),
//                     const Text(
//                       'Logout',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // App Version
//             Text(
//               'Version 1.0.0',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[500],
//               ),
//             ),
//
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(15),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Row(
//           children: [
//             Container(
//               width: 45,
//               height: 45,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 icon,
//                 color: Theme.of(context).primaryColor,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               size: 16,
//               color: Colors.grey[400],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNotificationItem(ThemeData theme) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 45,
//             height: 45,
//             decoration: BoxDecoration(
//               color: theme.primaryColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               Icons.notifications_outlined,
//               color: theme.primaryColor,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Notifications',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   notificationsEnabled ? 'Enabled' : 'Disabled',
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Switch(
//             value: notificationsEnabled,
//             onChanged: (value) {
//               setState(() {
//                 notificationsEnabled = value;
//               });
//             },
//             activeColor: theme.primaryColor,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDivider() {
//     return Divider(
//       height: 1,
//       thickness: 1,
//       color: Colors.grey[100],
//       indent: 20,
//       endIndent: 20,
//     );
//   }
//
//   void _showContactDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: const Text(
//           'Contact Us',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildContactItem(Icons.email, 'Email', 'support@example.com'),
//             const SizedBox(height: 12),
//             _buildContactItem(Icons.phone, 'Phone', '+1 234 567 8900'),
//             const SizedBox(height: 12),
//             _buildContactItem(Icons.chat, 'Live Chat', 'Available 24/7'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactItem(IconData icon, String title, String value) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: Theme.of(context).primaryColor, size: 20),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showAboutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: const Text(
//           'About Us',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: const Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.shopping_bag, size: 60, color: Color(0xFF2C3E50)),
//             SizedBox(height: 16),
//             Text(
//               'Your Store App',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Your trusted shopping companion. We bring you the best products at the best prices with a seamless shopping experience.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//                 height: 1.5,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Made with ❤️ by Your Team',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: const Text(
//           'Logout',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Perform logout
//               Navigator.pop(context);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red[400],
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: const Text(
//               'Logout',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Example usage
// void main() {
//   runApp(MaterialApp(
//     theme: ThemeData(
//       primaryColor: const Color(0xFF2C3E50),
//       colorScheme: const ColorScheme.light(
//         primary: Color(0xFF2C3E50),
//         secondary: Color(0xFFE74C3C),
//       ),
//     ),
//     home: const ProfilePage(),
//   ));
// }