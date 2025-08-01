import 'package:flutter/material.dart';
import '../../domain/entities/kyc_session.dart';

/// @file        kyc_status_banner.dart
/// @brief       Banner widget for displaying KYC status
/// @details     Shows current KYC verification status with appropriate
///              messages and actions for the user
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class KYCStatusBanner extends StatelessWidget {
  final KYCStatus status;
  final VoidCallback? onStartVerification;
  final VoidCallback? onRetry;

  const KYCStatusBanner({
    super.key,
    required this.status,
    this.onStartVerification,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // Don't show banner if verification is completed
    if (status == KYCStatus.completed) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getBannerColor(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            _getBannerIcon(),
            color: _getIconColor(context),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getBannerTitle(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: _getTextColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getBannerMessage(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _getTextColor(context),
                      ),
                ),
              ],
            ),
          ),
          if (_shouldShowAction())
            TextButton(
              onPressed: _getActionCallback(),
              child: Text(
                _getActionText(),
                style: TextStyle(
                  color: _getActionColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getBannerColor(BuildContext context) {
    switch (status) {
      case KYCStatus.notStarted:
        return Colors.orange.withOpacity(0.1);
      case KYCStatus.inProgress:
        return Colors.blue.withOpacity(0.1);
      case KYCStatus.underReview:
        return Colors.yellow.withOpacity(0.1);
      case KYCStatus.failed:
        return Colors.red.withOpacity(0.1);
      case KYCStatus.expired:
        return Colors.grey.withOpacity(0.1);
      case KYCStatus.completed:
        return Colors.transparent;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (status) {
      case KYCStatus.notStarted:
        return Colors.orange;
      case KYCStatus.inProgress:
        return Colors.blue;
      case KYCStatus.underReview:
        return Colors.yellow.shade700;
      case KYCStatus.failed:
        return Colors.red;
      case KYCStatus.expired:
        return Colors.grey;
      case KYCStatus.completed:
        return Colors.transparent;
    }
  }

  Color _getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;
  }

  Color _getActionColor(BuildContext context) {
    switch (status) {
      case KYCStatus.notStarted:
      case KYCStatus.failed:
      case KYCStatus.expired:
        return Colors.blue;
      case KYCStatus.inProgress:
      case KYCStatus.underReview:
        return Colors.grey;
      case KYCStatus.completed:
        return Colors.transparent;
    }
  }

  IconData _getBannerIcon() {
    switch (status) {
      case KYCStatus.notStarted:
        return Icons.verified_user_outlined;
      case KYCStatus.inProgress:
        return Icons.hourglass_empty;
      case KYCStatus.underReview:
        return Icons.pending_actions;
      case KYCStatus.failed:
        return Icons.error_outline;
      case KYCStatus.expired:
        return Icons.access_time;
      case KYCStatus.completed:
        return Icons.check_circle;
    }
  }

  String _getBannerTitle() {
    switch (status) {
      case KYCStatus.notStarted:
        return 'Verificación de Identidad Requerida';
      case KYCStatus.inProgress:
        return 'Verificación en Progreso';
      case KYCStatus.underReview:
        return 'Verificación en Revisión';
      case KYCStatus.failed:
        return 'Verificación Fallida';
      case KYCStatus.expired:
        return 'Sesión Expirada';
      case KYCStatus.completed:
        return 'Verificación Completada';
    }
  }

  String _getBannerMessage() {
    switch (status) {
      case KYCStatus.notStarted:
        return 'Complete su verificación de identidad para continuar usando la plataforma';
      case KYCStatus.inProgress:
        return 'Complete el proceso de verificación para continuar';
      case KYCStatus.underReview:
        return 'Su documentación está siendo revisada. Esto puede tomar hasta 24 horas';
      case KYCStatus.failed:
        return 'La verificación no pudo completarse. Intente nuevamente';
      case KYCStatus.expired:
        return 'Su sesión de verificación ha expirado. Inicie una nueva verificación';
      case KYCStatus.completed:
        return 'Su identidad ha sido verificada exitosamente';
    }
  }

  bool _shouldShowAction() {
    return status == KYCStatus.notStarted ||
        status == KYCStatus.failed ||
        status == KYCStatus.expired;
  }

  String _getActionText() {
    switch (status) {
      case KYCStatus.notStarted:
        return 'Verificar';
      case KYCStatus.failed:
      case KYCStatus.expired:
        return 'Reintentar';
      case KYCStatus.inProgress:
      case KYCStatus.underReview:
      case KYCStatus.completed:
        return '';
    }
  }

  VoidCallback? _getActionCallback() {
    switch (status) {
      case KYCStatus.notStarted:
        return onStartVerification;
      case KYCStatus.failed:
      case KYCStatus.expired:
        return onRetry ?? onStartVerification;
      case KYCStatus.inProgress:
      case KYCStatus.underReview:
      case KYCStatus.completed:
        return null;
    }
  }
}
