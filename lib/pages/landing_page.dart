import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late ScrollController _scrollController;
  bool _isScrolled = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 80 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 80 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 800;

    return Scaffold(
      key: _scaffoldKey, 
      backgroundColor: AppColors.sand,
      extendBodyBehindAppBar: true,
      
      endDrawer: Drawer(
        backgroundColor: AppColors.earthBrown,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: BrandLogo(fontSize: 22, primaryColor: Colors.white),
              ),
              const Divider(color: Colors.white24),
              const _MobileDrawerLink(title: 'Destinations', icon: Icons.map),
              const _MobileDrawerLink(title: 'Vibes', icon: Icons.local_fire_department),
              const _MobileDrawerLink(title: 'Our Guides', icon: Icons.group),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: SavannahButton(text: 'Sign In', onPressed: () {}),
                ),
              )
            ],
          ),
        ),
      ),
      
      appBar: AppBar(
        backgroundColor: _isScrolled ? AppColors.earthBrown.withOpacity(0.98) : Colors.transparent,
        elevation: _isScrolled ? 8 : 0,
        toolbarHeight: 90, 
        title: Padding(
          padding: EdgeInsets.only(left: isMobile ? 8.0 : 40.0),
          child: BrandLogo(fontSize: isMobile ? 22 : 26),
        ),
        actions: isMobile 
          ? [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 32), 
                padding: const EdgeInsets.only(right: 16),
                onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              )
            ]
          : [
            const _NavBarLink(title: 'Destinations'),
            const _NavBarLink(title: 'Vibes'),
            const _NavBarLink(title: 'Our Guides'),
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, top: 20.0, bottom: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.savannahGold, 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  elevation: 4,
                ),
                onPressed: () {},
                child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            )
          ],
      ),
      
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // --- 1. HERO SECTION ---
            SizedBox(
              height: screenSize.height * 0.95,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/id/1018/1920/1080'), // Placeholder for Hero
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  
                  Positioned(
                    top: isMobile ? screenSize.height * 0.25 : screenSize.height * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            'Discover the Soul\nof Kenya',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isMobile ? 48 : 72, 
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.05,
                              letterSpacing: -1.0,
                              shadows: const [Shadow(color: Colors.black45, blurRadius: 20, offset: Offset(0, 5))],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Immersive city walks, hidden trails, and authentic local experiences\ncurated by the people who know it best.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 22, 
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                              shadows: const [Shadow(color: Colors.black87, blurRadius: 10, offset: Offset(0, 2))],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: isMobile ? 40 : 80,
                    child: Container(
                      width: isMobile ? screenSize.width * 0.9 : 800,
                      padding: EdgeInsets.all(isMobile ? 20 : 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(isMobile ? 24 : 100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          )
                        ],
                      ),
                      child: isMobile 
                        ? Column(
                            children: [
                              const _SearchInput(icon: Icons.location_on, hint: 'Where to? (e.g. Nairobi)', isMobile: true),
                              Divider(color: Colors.grey.shade200, height: 20),
                              const _SearchInput(icon: Icons.calendar_today, hint: 'Select Dates', isMobile: true),
                              Divider(color: Colors.grey.shade200, height: 20),
                              const _SearchInput(icon: Icons.people, hint: 'Guests', isMobile: true),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.savannahSunset,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  onPressed: () {},
                                  child: const Text('SEARCH TOURS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                              )
                            ],
                          )
                        : Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const _SearchInput(icon: Icons.location_on, hint: 'Where to? (e.g. Nairobi)'),
                              Container(width: 1, height: 40, color: Colors.grey.shade300),
                              const _SearchInput(icon: Icons.calendar_today, hint: 'Select Dates'),
                              Container(width: 1, height: 40, color: Colors.grey.shade300),
                              const _SearchInput(icon: Icons.people, hint: 'Guests'),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: AppColors.savannahSunset,
                                  child: IconButton(
                                    icon: const Icon(Icons.search, color: Colors.white, size: 28),
                                    onPressed: () {},
                                  ),
                                ),
                              )
                            ],
                          ),
                    ),
                  ),
                ],
              ),
            ),

            // --- 2. TRUST & STATS RIBBON ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: AppColors.earthBrown,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 40,
                spacing: 20,
                children: const [
                  _StatItem(number: '12,000+', label: 'Happy Travelers'),
                  _StatItem(number: '50+', label: 'Verified Local Guides'),
                  _StatItem(number: '4.9/5', label: 'Average Review Rating'),
                  _StatItem(number: '100%', label: 'Secure M-Pesa Booking'),
                ],
              ),
            ),

            // --- 3. CURATED TOURS SECTION (YOUR CUSTOM WEBP FILES) ---
            Container(
              padding: const EdgeInsets.only(top: 80, bottom: 80, left: 20, right: 20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SectionHeader(title: 'Experiences You\'ll Love'),
                  const SizedBox(height: 12),
                  Text(
                    'Step off the beaten path and dive straight into the culture.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: isMobile ? 16 : 20, color: Colors.black54),
                  ),
                  const SizedBox(height: 60),
                  
                  Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children: const [
                      TourCard(
                        title: 'Nairobi Noir: History Walk',
                        imagePath: 'assets/images/nairobi_noir.webp', // Inserted
                        price: '2,500 KES',
                        duration: '3 Hours',
                      ),
                      TourCard(
                        title: 'Nakuru Sundowner Trail',
                        imagePath: 'assets/images/nakuru_sundowner.webp', // Inserted
                        price: '3,000 KES',
                        duration: '4 Hours',
                      ),
                      TourCard(
                        title: 'Karura Forest Canopy',
                        imagePath: 'assets/images/karura_canopy.webp', // Inserted
                        price: '1,500 KES',
                        duration: '2 Hours',
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.earthBrown,
                      side: const BorderSide(color: AppColors.earthBrown, width: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child: const Text('VIEW ALL EXPERIENCES', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  )
                ],
              ),
            ),

            // --- 4. WHY CHOOSE US ---
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              width: double.infinity,
              child: Column(
                children: [
                  const SectionHeader(title: 'The Fullpath Difference'),
                  const SizedBox(height: 60),
                  Wrap(
                    spacing: 60,
                    runSpacing: 60,
                    alignment: WrapAlignment.center,
                    children: const [
                      _FeatureBlock(
                        icon: Icons.explore,
                        title: 'Vetted Local Experts',
                        description: 'Every guide is handpicked, background-checked, and passionate about their city.',
                      ),
                      _FeatureBlock(
                        icon: Icons.flash_on,
                        title: 'Instant Booking',
                        description: 'No waiting for emails. See live availability, book instantly, and get your QR ticket.',
                      ),
                      _FeatureBlock(
                        icon: Icons.payments,
                        title: 'Seamless Payments',
                        description: 'Pay securely using M-Pesa STK push or any major credit card in seconds.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- 5. NEWSLETTER (YOUR LION BACKGROUND) ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.earthBrown,
                image: DecorationImage(
                  image: const AssetImage('assets/images/lion.webp'), // Inserted the lion!
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.55), BlendMode.darken),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Join the Adventure',
                    style: TextStyle(
                      fontSize: isMobile ? 36 : 46, 
                      fontWeight: FontWeight.w900, 
                      color: Colors.white,
                      shadows: const [Shadow(color: Colors.black87, blurRadius: 10, offset: Offset(0, 2))],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Get secret trails and early bird discounts delivered to your inbox.',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 20, 
                      color: Colors.white, 
                      fontWeight: FontWeight.w500,
                      shadows: const [Shadow(color: Colors.black87, blurRadius: 8, offset: Offset(0, 1))],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  
                  SizedBox(
                    width: isMobile ? double.infinity : 550,
                    child: isMobile 
                    ? Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your email address',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.95),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: SavannahButton(text: 'Subscribe', onPressed: () {}),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your email address',
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.95),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SavannahButton(text: 'Subscribe', onPressed: () {}),
                        ],
                      ),
                  )
                ],
              ),
            ),
            
            // --- 6. EXPANDED PROFESSIONAL FOOTER ---
            Container(
              width: double.infinity,
              color: AppColors.earthBrown,
              padding: const EdgeInsets.only(top: 80, bottom: 40, left: 20, right: 20),
              child: Column(
                children: [
                  Wrap(
                    spacing: 60,
                    runSpacing: 40,
                    alignment: isMobile ? WrapAlignment.start : WrapAlignment.center,
                    children: [
                      // Branding
                      SizedBox(
                        width: 380, 
                        child: Column(
                          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                            const BrandLogo(fontSize: 34),
                            const SizedBox(height: 20),
                            Text(
                              'Redefining the way you experience Kenya. Authentic, seamless, and unforgettable.', 
                              textAlign: isMobile ? TextAlign.center : TextAlign.left,
                              style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.6)
                            ),
                          ],
                        ),
                      ),
                      // Links
                      const _FooterLinkColumn(title: 'Company', links: ['About Us', 'Careers', 'Sustainability', 'Contact']),
                      const _FooterLinkColumn(title: 'Discover', links: ['Nairobi Walks', 'Nakuru Trails', 'Coast Vibes', 'Gift Cards']),
                      const _FooterLinkColumn(title: 'Support', links: ['FAQ', 'Cancellation Policy', 'Guide Login', 'Terms of Service']),
                    ],
                  ),
                  const SizedBox(height: 80),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 24),
                  const Text('© 2026 FULLPATH TOURS. Handcrafted in Kenya.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontSize: 14, letterSpacing: 1.2)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// PRIVATE HELPER WIDGETS 
// ==========================================

class _MobileDrawerLink extends StatelessWidget {
  final String title;
  final IconData icon;

  const _MobileDrawerLink({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.savannahGold),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
      onTap: () {
        Navigator.pop(context); 
      },
    );
  }
}

class _NavBarLink extends StatelessWidget {
  final String title;
  const _NavBarLink({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title, 
          style: const TextStyle(
            color: Colors.white, 
            fontSize: 16, 
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          )
        ),
      ),
    );
  }
}

class _SearchInput extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool isMobile;
  
  const _SearchInput({required this.icon, required this.hint, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? double.infinity : 200,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.savannahGold, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;
  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(number, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: AppColors.savannahGold)),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1.1)),
      ],
    );
  }
}

class _FeatureBlock extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureBlock({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    
    return SizedBox(
      width: isMobile ? double.infinity : 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: const BoxDecoration(
              color: AppColors.sand,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 52, color: AppColors.savannahGold),
          ),
          const SizedBox(height: 24),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.earthBrown)),
          const SizedBox(height: 12),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.black54, height: 1.6)),
        ],
      ),
    );
  }
}

class _FooterLinkColumn extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterLinkColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(link, style: const TextStyle(color: Colors.white70, fontSize: 16)),
            ),
          )).toList(),
        ],
      ),
    );
  }
}