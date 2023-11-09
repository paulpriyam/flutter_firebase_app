# flutter_firebase

A new Flutter project.


## Dependency Required
Firebase dependency
```
  firebase_core: ^2.21.0
  firebase_auth: ^4.12.1
  firebase_storage: ^11.4.1
  cloud_firestore: ^4.12.2
  firebase_database: ^10.3.3
```
Dependency to Generate UUID
```
 uuid: ^4.0.0
```
Dependency to show Toast
```
fluttertoast: ^8.2.2
```
Dependency required for Date fromat
```
intl: ^0.18.1
```
Now if you are fetching data from Firebase, you can use `FirebaseAnimatedList`  sample code below
```
 child: FirebaseAnimatedList(
              query: database,
              itemBuilder: (context, snapshot, animation, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all()),
                    child: ListTile(
                      title: Text(snapshot.child("postTitle").value.toString()),
                      titleTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      subtitle: ListTile(
                        title:
                            Text(snapshot.child("postDesc").value.toString()),
                        subtitle: Text(epochToDate(
                            snapshot.child("timeStamp").value.toString())),
                      ),
                    ),
                  ),
                );
              },
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            )
```
Alternatively you can use `streamBuilder` to achieve the same result
```
          Expanded(
              child: StreamBuilder(
            stream: database.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();
                return ListView.separated(
                    separatorBuilder: (ceontext, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all()),
                          child: ListTile(
                            title: Text(list[index]["postTitle"]),
                            titleTextStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            subtitle: ListTile(
                              title: Text(list[index]['postDesc']),
                              subtitle:
                                  Text(epochToDate(list[index]['timeStamp'])),
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
          ))
```

