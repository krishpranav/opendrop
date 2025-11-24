class CryptoConstants {
  static const String keyExchangeAlgorithm = 'X25519'; // Elliptic Curve Diffie-Hellman

  static const String encryptionAlgorithm = 'AES-256-GCM'; // AES Galois/Counter Mode

  static const int publicKeySize = 256; // 32 bytes
  static const int privateKeySize = 256; // 32 bytes
  static const int sharedSecretSize = 256; // 32 bytes
  static const int symmetricKeySize = 256; // 32 bytes for AES-256

  static const int nonceSize = 96; // 12 bytes (recommended for GCM)
  static const int tagSize = 128; // 16 bytes (authentication tag)

  static const int sessionKeyValidityMinutes = 10;
  static const int maxSessionsPerDevice = 1;

  static const int verificationCodeLength = 6; // For audio OOB verification
  static const int verificationCodeValiditySeconds = 30;

  static const String hashAlgorithm = 'SHA-256';
  static const int hashSize = 256; // 32 bytes

  static const String kdfAlgorithm = 'HKDF'; // HMAC-based Key Derivation Function
  static const String kdfInfo = 'OpenDropConnect_v1'; // Context info

  static const int saltSize = 128; // 16 bytes

  static const int minSecurityLevel = 128; // bits
  static const int recommendedSecurityLevel = 256; // bits

  static const int keyExchangeTimeoutSeconds = 15;
  static const int encryptionTimeoutSeconds = 5;

  static const int maxCryptoRetryAttempts = 2;
}
