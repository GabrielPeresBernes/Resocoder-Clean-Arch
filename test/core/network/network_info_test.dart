import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resocoder_clean_arch/core/network/network_info.dart';

@GenerateMocks([Connectivity])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  test(
    'should forward the call to Connectivity',
    () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);

      // act
      await networkInfo.isConnected;

      // assert
      verify(mockConnectivity.checkConnectivity());
    },
  );

  test(
    'should return false when there is no connectivity',
    () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, false);
    },
  );

  test(
    'should return true when there is wifi connectivity',
    () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, true);
    },
  );

  test(
    'should return true when there is mobile connectivity',
    () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.mobile);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, true);
    },
  );
}
