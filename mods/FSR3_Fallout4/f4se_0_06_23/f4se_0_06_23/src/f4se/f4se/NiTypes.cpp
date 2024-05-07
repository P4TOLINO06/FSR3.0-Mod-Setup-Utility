#include "f4se/NiTypes.h"

NiPoint3::NiPoint3()
{
	x = 0.0f;
	y = 0.0f;
	z = 0.0f;
}

NiPoint3 NiPoint3::operator- () const
{
	return NiPoint3(-x, -y, -z);
}

NiPoint3 NiPoint3::operator+ (const NiPoint3& pt) const
{
	return NiPoint3(x + pt.x, y + pt.y, z + pt.z);
}

NiPoint3 NiPoint3::operator- (const NiPoint3& pt) const
{
	return NiPoint3(x - pt.x, y - pt.y, z - pt.z);
}

NiPoint3& NiPoint3::operator+= (const NiPoint3& pt)
{
	x += pt.x;
	y += pt.y;
	z += pt.z;
	return *this;
}
NiPoint3& NiPoint3::operator-= (const NiPoint3& pt)
{
	x -= pt.x;
	y -= pt.y;
	z -= pt.z;
	return *this;
}

// Scalar operations
NiPoint3 NiPoint3::operator* (float scalar) const
{
	return NiPoint3(scalar * x, scalar * y, scalar * z);
}
NiPoint3 NiPoint3::operator/ (float scalar) const
{
	float invScalar = 1.0f / scalar;
	return NiPoint3(invScalar * x, invScalar * y, invScalar * z);
}

NiPoint3& NiPoint3::operator*= (float scalar)
{
	x *= scalar;
	y *= scalar;
	z *= scalar;
	return *this;
}
NiPoint3& NiPoint3::operator/= (float scalar)
{
	float invScalar = 1.0f / scalar;
	x *= invScalar;
	y *= invScalar;
	z *= invScalar;
	return *this;
}

NiMatrix43 NiMatrix43::operator* (const NiMatrix43& rhs) const
{
	NiMatrix43 tmp;
	tmp.data[0][0] =
		data[0][0] * rhs.data[0][0] +
		data[0][1] * rhs.data[1][0] +
		data[0][2] * rhs.data[2][0];
	tmp.data[1][0] =
		data[1][0] * rhs.data[0][0] +
		data[1][1] * rhs.data[1][0] +
		data[1][2] * rhs.data[2][0];
	tmp.data[2][0] =
		data[2][0] * rhs.data[0][0] +
		data[2][1] * rhs.data[1][0] +
		data[2][2] * rhs.data[2][0];
	tmp.data[0][1] =
		data[0][0] * rhs.data[0][1] +
		data[0][1] * rhs.data[1][1] +
		data[0][2] * rhs.data[2][1];
	tmp.data[1][1] =
		data[1][0] * rhs.data[0][1] +
		data[1][1] * rhs.data[1][1] +
		data[1][2] * rhs.data[2][1];
	tmp.data[2][1] =
		data[2][0] * rhs.data[0][1] +
		data[2][1] * rhs.data[1][1] +
		data[2][2] * rhs.data[2][1];
	tmp.data[0][2] =
		data[0][0] * rhs.data[0][2] +
		data[0][1] * rhs.data[1][2] +
		data[0][2] * rhs.data[2][2];
	tmp.data[1][2] =
		data[1][0] * rhs.data[0][2] +
		data[1][1] * rhs.data[1][2] +
		data[1][2] * rhs.data[2][2];
	tmp.data[2][2] =
		data[2][0] * rhs.data[0][2] +
		data[2][1] * rhs.data[1][2] +
		data[2][2] * rhs.data[2][2];
	return tmp;
}

NiPoint3 NiMatrix43::operator* (const NiPoint3& pt) const
{
	return NiPoint3
		(
		data[0][0]*pt.x+data[0][1]*pt.y+data[0][2]*pt.z,
		data[1][0]*pt.x+data[1][1]*pt.y+data[1][2]*pt.z,
		data[2][0]*pt.x+data[2][1]*pt.y+data[2][2]*pt.z
		);
}

NiMatrix43 NiMatrix43::Transpose() const
{
	NiMatrix43 result;
	result.data[0][0] = data[0][0];
	result.data[0][1] = data[1][0];
	result.data[0][2] = data[2][0];
	result.data[0][3] = data[0][3];
	result.data[1][0] = data[0][1];
	result.data[1][1] = data[1][1];
	result.data[1][2] = data[2][1];
	result.data[1][3] = data[1][3];
	result.data[2][0] = data[0][2];
	result.data[2][1] = data[1][2];
	result.data[2][2] = data[2][2];
	result.data[2][3] = data[2][3];
	return result;
}

// Converted from Java to C
// http://www.euclideanspace.com/maths/geometry/rotations/conversions/matrixToEuler/index.htm
void NiMatrix43::GetEulerAngles(float * heading, float * attitude, float * bank)
{
	if (data[1][0] > 0.998) { // singularity at north pole
		*heading = atan2(data[0][2], data[2][2]);
		*attitude = MATH_PI / 2;
		*bank = 0;
	}
	else if (data[1][0] < -0.998) { // singularity at south pole
		*heading = atan2(data[0][2], data[2][2]);
		*attitude = -MATH_PI / 2;
		*bank = 0;
	}
	else {
		*heading = atan2(-data[2][0], data[0][0]);
		*bank = atan2(-data[1][2], data[1][1]);
		*attitude = asin(data[1][0]);
	}
}

// Converted from Java to C
// http://www.euclideanspace.com/maths/geometry/rotations/conversions/eulerToMatrix/index.htm
void NiMatrix43::SetEulerAngles(float heading, float attitude, float bank)
{
	double ch = cos(heading);
	double sh = sin(heading);
	double ca = cos(attitude);
	double sa = sin(attitude);
	double cb = cos(bank);
	double sb = sin(bank);

	data[0][0] = ch * ca;
	data[0][1] = sh * sb - ch * sa * cb;
	data[0][2] = ch * sa * sb + sh * cb;
	data[1][0] = sa;
	data[1][1] = ca * cb;
	data[1][2] = -ca * sb;
	data[2][0] = -sh * ca;
	data[2][1] = sh * sa * cb + ch * sb;
	data[2][2] = -sh * sa * sb + ch * cb;
}

NiTransform NiTransform::operator*(const NiTransform &rhs) const
{
	NiTransform tmp;
	tmp.scale = scale * rhs.scale;
	tmp.rot = rot * rhs.rot;
	tmp.pos = pos + (rot * rhs.pos) * scale;
	return tmp;
}

NiPoint3 NiTransform::operator*(const NiPoint3 & pt) const
{
	return (((rot * pt) * scale) + pos);
}
