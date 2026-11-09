import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedproduct() async {
  final col = FirebaseFirestore.instance.collection('products');

  final existing = await col.limit(1).get();
  if (existing.docs.isNotEmpty) return;

  final products = [
    {
      'name': 'Air Jordan 1 Low',
      'category': 'Shoes',
      'description': 'An iconic look that lasts. This AJ1 pairs the classic design of the original with premium materials that will keep you going all day.',
      'imageurl': 'https://static.nike.com/a/images/t_web_pw_592_v2/f_auto/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/49f4a986-d235-46f6-98c9-4ce8ab428425/AIR+JORDAN+1+LOW+GS.png',

      'price': 90,
    },

    {
      'name': 'Jordan Strada Realtree',
      'category': 'Shoes',
      'description': ' The encapsulated Air-Sole unit in the heel and Cushlon 3.0 foam in the midsole stay comfy on the go. Premium woven materials offer breathability, while the plush collar and padded tongue were designed for easy on and off.',
      'imageurl': 'https://static.nike.com/a/images/t_web_pdp_535_v2/f_auto,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/08784465-a841-4f17-b445-0788084f7925/JORDAN+STRADA+RLT.png',

      'price': 130,
    },
    {
      'name': 'Jordan DMSN 95 Realtree',
      'category': 'Shoes',
      'description': 'The DMSN 95 remixes a classic Jordan silhouette for the next generation. Inspired by the AJ11, it brings back the retro style and feel with that Realtree camo and a modern twist—designed with versatility and comfort in mind for the sneakerhead thats always on the go.',
      'imageurl': 'https://static.nike.com/a/images/t_web_pdp_535_v2/f_auto,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/147b970a-3b97-4018-8a64-cc41948e2050/JORDAN+DMSN+95+RLT.png',

      'price': 145,
    },
    {
      'name': 'Jordan Sixty Plus Low',
      'category': 'Shoes',
      'description': 'The Sixty Plus is back in low-top form, combining the four classic Jordans that MJ wore during his five 60-plus point games. What you end up with is a sneaker that channels greatness through iconic details, celebrating the GOATs legacy.',
      'imageurl': 'https://static.nike.com/a/images/t_web_pdp_535_v2/f_auto,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/7f28aef7-c33e-4ad8-811c-3984523e5c90/JORDAN+SIXTY+PLUS+LOW.png',

      'price': 145,
    },
    {
      'name': 'Air Jordan 3 Retro "True Blue"',
      'category': 'Shoes',
      'description': 'Clean and supreme, the AJ3 returns with all of its classic style and grace. Premium leather in the upper—with that luxurious elephant print texture—combines with visible Air in the sole to make a comfortable, everyday icon. And for the first time in a decade, "True Blue" details bring back the iconic colorway.',
      'imageurl': 'https://static.nike.com/a/images/t_web_pw_592_v2/f_auto/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/49f4a986-d235-46f6-98c9-4ce8ab428425/AIR+JORDAN+1+LOW+GS.png',

      'price': 230,
    },
    {
      'name': 'Air Jordan 13 Retro "Flint"',
      'category': 'Shoes',
      'description': 'The Air Jordan 13 brings back the memorable shoe that MJ wore during the 97-98 season, all the way to his 6th championship title. From the quilted overlay, sculpted midsole and holographic eye, it comes fully equipped with all the signature details.',
      'imageurl': 'https://static.nike.com/a/images/t_web_pdp_535_v2/f_auto,u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/bc719443-82b8-405c-8dd1-40ca1aa6a03a/AIR+JORDAN+13+RETRO+%28GS%29.png',

      'price': 301,
    },
  ];
  for (final p in products) {
    await col.add(p);
  }
}
