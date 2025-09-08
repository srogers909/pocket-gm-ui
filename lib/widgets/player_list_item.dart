import 'package:flutter/material.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import '../theme/colors.dart';
import '../utils/rating_utils.dart';

class PlayerListItem extends StatefulWidget {
  final Player player;

  const PlayerListItem({
    super.key,
    required this.player,
  });

  @override
  State<PlayerListItem> createState() => _PlayerListItemState();
}

class _PlayerListItemState extends State<PlayerListItem> {
  bool _isExpanded = false;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: ExpansionTile(
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Row(
          children: [
            // Position and Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.player.primaryPosition} - ${widget.player.commonName}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.player.birthInfo.split(' ').length > 1 ? 
                      widget.player.birthInfo.split(' ')[1] : 'Age unknown',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.background.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            // Overall Rating Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: RatingUtils.getRatingBackgroundColor(widget.player.overallRating),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: RatingUtils.getRatingBorderColor(widget.player.overallRating),
                  width: 1.5,
                ),
              ),
              child: Text(
                RatingUtils.getLetterGrade(widget.player.overallRating),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: RatingUtils.getRatingColor(widget.player.overallRating),
                  shadows: [
                    Shadow(
                      blurRadius: 1.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        subtitle: widget.player.fanNickname != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '"${widget.player.fanNickname}"',
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: AppColors.background.withValues(alpha: 0.7),
                  ),
                ),
              )
            : null,
        children: [
          PlayerDetailsCard(player: widget.player),
        ],
      ),
    );
  }
}

class PlayerDetailsCard extends StatelessWidget {
  final Player player;

  const PlayerDetailsCard({
    super.key,
    required this.player,
  });

  /// Builds a rating chip widget with letter grade
  Widget _buildRatingChip(String label, int rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: RatingUtils.getRatingBackgroundColor(rating),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: RatingUtils.getRatingBorderColor(rating),
          width: 1,
        ),
      ),
      child: Text(
        '$label: ${RatingUtils.getLetterGrade(rating)}',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: RatingUtils.getRatingColor(rating),
          shadows: [
            Shadow(
              blurRadius: 1.0,
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(1.0, 1.0),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a rating bar widget showing F D C B A scale with filled progress
  Widget _buildRatingBar(String label, int rating) {
    const double barHeight = 24.0;
    const double barWidth = 200.0;
    
    // Calculate fill percentage based on grade boundaries
    // Since labels are equally spaced, we need to map the rating to the correct position
    double fillPercentage;
    if (rating < 60) {
      // F range: 0-59 maps to 0-25% (first quarter)
      fillPercentage = (rating / 60.0) * 0.25;
    } else if (rating < 70) {
      // D range: 60-69 maps to 25-50% (second quarter)
      fillPercentage = 0.25 + ((rating - 60) / 10.0) * 0.25;
    } else if (rating < 80) {
      // C range: 70-79 maps to 50-75% (third quarter)
      fillPercentage = 0.50 + ((rating - 70) / 10.0) * 0.25;
    } else if (rating < 90) {
      // B range: 80-89 maps to 75-100% (fourth quarter)
      fillPercentage = 0.75 + ((rating - 80) / 10.0) * 0.25;
    } else {
      // A range: 90-100 maps to 100% (at or past the A mark)
      fillPercentage = 1.0;
    }
    
    fillPercentage = fillPercentage.clamp(0.0, 1.0);
    final Color ratingColor = RatingUtils.getRatingColor(rating);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Label
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.background.withValues(alpha: 0.9),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Rating Bar
          SizedBox(
            width: barWidth,
            height: barHeight,
            child: Stack(
              children: [
                // Background bar
                Container(
                  width: barWidth,
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                ),
                // Filled bar
                Container(
                  width: barWidth * fillPercentage,
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: ratingColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                // Grade labels overlay with equal spacing
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildGradeLabel('F'),
                        _buildGradeLabel('D'),
                        _buildGradeLabel('C'),
                        _buildGradeLabel('B'),
                        _buildGradeLabel('A'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Current grade
          Text(
            RatingUtils.getLetterGrade(rating),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ratingColor,
              shadows: [
                Shadow(
                  blurRadius: 0.5,
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a grade label for the rating bar
  Widget _buildGradeLabel(String grade) {
    return Text(
      grade,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.black.withValues(alpha: 0.6),
        shadows: [
          Shadow(
            blurRadius: 1.0,
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(0.5, 0.5),
          ),
        ],
      ),
    );
  }

  /// Builds a section with title and content
  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        content,
        const SizedBox(height: 16),
      ],
    );
  }

  /// Builds physical attributes section
  Widget _buildPhysicalAttributes() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.background.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Height: ${player.heightFormatted}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.background.withValues(alpha: 0.8),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Weight: ${player.weightLbs} lbs',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.background.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'College: ${player.college}',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.background.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Born: ${player.birthInfo}',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.background.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds position-specific ratings section
  Widget _buildPositionRatings() {
    final attributes = player.positionAttributes;
    if (attributes == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        _buildRatingBar(attributes.attribute1, player.positionRating1),
        _buildRatingBar(attributes.attribute2, player.positionRating2),
        _buildRatingBar(attributes.attribute3, player.positionRating3),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.background.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Player Name Section
          _buildSection(
            'Player Details',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full Name: ${player.fullName}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.background.withValues(alpha: 0.9),
                  ),
                ),
                if (player.fanNickname != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Nickname: "${player.fanNickname}"',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: AppColors.background.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Physical Attributes
          _buildSection(
            'Physical Attributes',
            _buildPhysicalAttributes(),
          ),

          // Core Ratings
          _buildSection(
            'Core Ratings',
            Column(
              children: [
                _buildRatingBar('Overall', player.overallRating),
                _buildRatingBar('Potential', player.potentialRating),
                _buildRatingBar('Durability', player.durabilityRating),
                _buildRatingBar('Football IQ', player.footballIqRating),
                _buildRatingBar('Fan Popularity', player.fanPopularity),
                _buildRatingBar('Morale', player.morale),
              ],
            ),
          ),

          // Position-Specific Ratings
          if (player.positionAttributes != null)
            _buildSection(
              'Position Ratings (${player.primaryPosition})',
              _buildPositionRatings(),
            ),
        ],
      ),
    );
  }
}
