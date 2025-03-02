part of './../../index.dart';

class CallDropdownComponent extends StatefulWidget {
  @override
  _CallDropdownComponentState createState() => _CallDropdownComponentState();
}

class _CallDropdownComponentState extends State<CallDropdownComponent> {
  String _selectedCountry = 'Other Countries';

  List<Map<String, String>> _countries = [
    {'name': 'United States', 'phone': '+1 123 456 7890', 'flag': '🇺🇸'},
    {'name': 'United Kingdom', 'phone': '+44 123 456 7890', 'flag': '🇬🇧'},
    {'name': 'Canada', 'phone': '+1 123 456 7890', 'flag': '🇨🇦'},
    {'name': 'Nigeria', 'phone': '+234 123 4567890', 'flag': '🇳🇬'},
  ];

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            title: Text(_selectedCountry),
            trailing:
                Icon(_isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Container(
              height: 250,
              width: double.infinity,
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (var country in _countries)
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Text(country['flag']!),
                        radius: 15,
                      ),
                      title: Text(country['name']!),
                      subtitle: Text(country['phone']!),
                      trailing: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          'assets/Phone.svg',
                        ),
                        radius: 15,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
