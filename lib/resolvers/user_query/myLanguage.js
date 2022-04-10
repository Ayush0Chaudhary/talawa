const User = require('../../models/User');
const { NotFoundError } = require('errors');
const requestContext = require('talawa-request-context');

module.exports = async (parent, args, context) => {
  const user = await User.findOne({
    _id: context.userId,
  });

  if (!user) {
    throw new NotFoundError(
      process.env.NODE_ENV !== 'production'
      ? 'User not found'
      : requestContext.translate('user.notFound'),
      'user.notFound',
      'user'
    );
  }

  return user.appLanguageCode;
};