import 'package:flutter/material.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/core/errors/asset/asset_error_codes.dart';
import 'package:equatable/equatable.dart';

/// @file        asset_failure.dart
/// @brief       Asset failure for NemorixPay.
/// @details     This class represents asset-related errors in the data/domain layer.
///              It provides a standardized way to handle asset-related errors with
///              proper error code mapping and internationalization support.
/// @author      Miguel Fagundez
/// @date        2025-05-25
/// @version     1.0
/// @copyright   Apache 2.0 License

class AssetFailure extends Failure {
  /// Human-readable error message
  final String assetMessage;

  /// Error code that identifies the type of error
  final String assetCode;

  /// Creates a new [AssetFailure]
  ///
  /// Both [assetCode] and [assetMessage] are required
  AssetFailure({required this.assetMessage, required this.assetCode})
    : super(message: assetMessage, code: assetCode);

  /// Creates an [AssetFailure] for price update errors
  factory AssetFailure.priceUpdateFailed(String message) {
    return AssetFailure(
      assetCode: AssetErrorCode.priceUpdateFailed.code,
      assetMessage: message,
    );
  }

  /// Creates an [AssetFailure] for invalid price data errors
  factory AssetFailure.invalidPriceData(String message) {
    return AssetFailure(
      assetCode: AssetErrorCode.invalidPriceData.code,
      assetMessage: message,
    );
  }

  /// Creates an [AssetFailure] for price history not found errors
  factory AssetFailure.priceHistoryNotFound(String message) {
    return AssetFailure(
      assetCode: AssetErrorCode.priceHistoryNotFound.code,
      assetMessage: message,
    );
  }

  /// Creates an [AssetFailure] for network errors
  factory AssetFailure.networkError(String message) {
    return AssetFailure(
      assetCode: AssetErrorCode.networkError.code,
      assetMessage: message,
    );
  }

  /// Creates an [AssetFailure] for timeout errors
  factory AssetFailure.timeoutError(String message) {
    return AssetFailure(
      assetCode: AssetErrorCode.timeoutError.code,
      assetMessage: message,
    );
  }

  /// Creates an [AssetFailure] for invalid symbol errors
  factory AssetFailure.invalidSymbol(String message) {
    return AssetFailure(
      assetCode: AssetErrorCode.invalidSymbol.code,
      assetMessage: message,
    );
  }

  /// Creates an [AssetFailure] for data parsing errors
  factory AssetFailure.dataParsingError(String message) {
    return AssetFailure(
      assetCode: AssetErrorCode.dataParsingError.code,
      assetMessage: message,
    );
  }

  /// Creates an [AssetFailure] for assets list errors
  factory AssetFailure.assetsListFailed(String message) {
    return AssetFailure(
      assetCode: AssetErrorCode.assetsListFailed.code,
      assetMessage: message,
    );
  }

  /// Creates an [AssetFailure] for unknown errors
  factory AssetFailure.unknown(String message) {
    return AssetFailure(
      assetCode: AssetErrorCode.unknown.code,
      assetMessage: message,
    );
  }

  /// Checks if this failure represents a specific error type
  bool isErrorType(AssetErrorCode errorCode) => assetCode == errorCode.code;

  /// Gets a localized message for this failure
  String getLocalizedMessage(BuildContext context) {
    return AssetErrorCode.getMessageForCode(assetCode, context);
  }
}
