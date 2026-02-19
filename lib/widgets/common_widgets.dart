import 'package:flutter/material.dart';
import 'dart:math';

// --- DESIGN SYSTEM: SAVANNAH THEME ---
class AppColors {
  static const Color savannahSunset = Color(0xFFE07A5F); 
  static const Color earthBrown = Color(0xFF3D405B);     
  static const Color savannahGold = Color(0xFFA67B5B);   
  static const Color sand = Color(0xFFF4F1DE);           
}

// --- WORLD-CLASS BRAND LOGO WIDGET ---
class BrandLogo extends StatelessWidget {
  final double fontSize;
  final Color primaryColor;
  final Color accentColor;

  const BrandLogo({
    Key? key, 
    this.fontSize = 28, 
    this.primaryColor = Colors.white, 
    this.accentColor = AppColors.savannahGold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50), 
            child: Image.asset(
              'assets/images/logo.png', // Your custom logo path
              height: fontSize * 1.8, 
              width: fontSize * 1.8,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  height: fontSize * 1.8, 
                  width: fontSize * 1.8,
                  child: const Center(
                    child: Text('Check\nPath', textAlign: TextAlign.center, style: TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'FULL',
                style: TextStyle(
                  fontSize: fontSize,
                  color: primaryColor,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                'PATH',
                style: TextStyle(
                  fontSize: fontSize,
                  color: primaryColor,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 10),
              ..._buildWindingPathWord('TOURS', accentColor, fontSize * 0.55),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildWindingPathWord(String word, Color color, double size) {
    return word.split('').asMap().entries.map((entry) {
      int idx = entry.key;
      String char = entry.value;
      
      double yOffset = sin(idx * 1.5) * 4.0;
      
      return Transform.translate(
        offset: Offset(0, yOffset),
        child: Padding(
          padding: const EdgeInsets.only(right: 3.0),
          child: Text(
            char,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: size,
              letterSpacing: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }).toList();
  }
}

// --- PRIMARY CALL TO ACTION BUTTON ---
class SavannahButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SavannahButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.savannahSunset,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 6,
        shadowColor: AppColors.savannahSunset.withOpacity(0.4),
      ),
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.w900, 
          letterSpacing: 1.5,
          fontSize: 16,
        ),
      ),
    );
  }
}

// --- TYPOGRAPHY: SECTION HEADER ---
class SectionHeader extends StatelessWidget {
  final String title;
  
  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isMobile ? 30 : 38,
          fontWeight: FontWeight.w900,
          color: AppColors.earthBrown,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}

// --- REUSABLE TOUR CARD ---
class TourCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String price;
  final String duration;

  const TourCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 380 ? screenWidth * 0.85 : 340.0;

    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: cardWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath), // Using AssetImage for your local .webp files
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.earthBrown,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined, size: 20, color: AppColors.savannahGold),
                          const SizedBox(width: 8),
                          Text(
                            duration, 
                            style: TextStyle(
                              color: Colors.grey.shade700, 
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.savannahSunset,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}