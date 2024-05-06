// ---- FNV Hash 1fbd27d88a25bdca

// ---- Created with 3Dmigoto v1.3.16 on Fri Mar  8 21:28:29 2024

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
}

cbuffer megashader_locals : register(b12)
{
  float zShiftScale : packoffset(c0);
  float parallaxScaleBias : packoffset(c0.y);
  float specularFresnel : packoffset(c0.z);
  float specularFalloffMult : packoffset(c0.w);
  float specularIntensityMult : packoffset(c1);
  float bumpiness : packoffset(c1.y);
  float useTessellation : packoffset(c1.z);
  float HardAlphaBlend : packoffset(c1.w);
}

cbuffer vehicle_globals : register(b7)
{
  bool switchOn : packoffset(c0);
  bool tyreDeformSwitchOn : packoffset(c0.y);
}

cbuffer vehicle_damage_locals : register(b11)
{
  float BoundRadius : packoffset(c0);
  float DamageMultiplier : packoffset(c0.y);
  float3 DamageTextureOffset : packoffset(c1);
  float4 DamagedWheelOffsets[2] : packoffset(c2);
  bool bDebugDisplayDamageMap : packoffset(c4);
  bool bDebugDisplayDamageScale : packoffset(c4.y);
}

cbuffer decal_per_bucket : register(b9)
{
  float3 gPositionScale : packoffset(c0);
}

cbuffer decal_per_instance : register(b6)
{

  struct
  {
    float4 constSet0;
    float4 vertexColor;
    float4 texcoordConst;
  } gPerInstCBuf[256] : packoffset(c0);

}

SamplerState DamageSampler_s : register(s2);
Texture2D<float4> DamageSampler : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : TEXCOORD0,
  float2 v2 : TEXCOORD1,
  float3 v3 : NORMAL0,
  float4 v4 : TANGENT0,
  uint v5 : TEXCOORD2,
  uint v6 : SV_InstanceID0,
  out float4 o0 : COLOR0,
  out float3 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD4,
  out float4 o4 : TEXCOORD5,
  out float4 o5 : TEXCOORD6,
  out float4 o6 : TEXCOORD7,
  out float4 o7 : SV_Position0,
  out float4 o8 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.zw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.x
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = gPositionScale.xyz * v0.xyz;
  r1.x = (int)v5.x * 3;
  o0.w = gPerInstCBuf[r1.x].constSet0.x * v1.z + gPerInstCBuf[r1.x].constSet0.y;
  r1.yzw = v3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.xyzw = v4.xyzw * float4(2,2,2,2) + float4(-1,-1,-1,-1);
  o1.xy = gPerInstCBuf[r1.x].texcoordConst.xy * v2.xy + gPerInstCBuf[r1.x].texcoordConst.zw;
  if (switchOn != 0) {
    r3.xyz = v0.xyz * gPositionScale.xyz + DamageTextureOffset.xyz;
    r3.w = dot(r3.xyz, r3.xyz);
    r3.w = sqrt(r3.w);
    r3.xyz = r3.xyz / r3.www;
    r3.z = 1 + -r3.z;
    r3.z = 0.5 * r3.z;
    r4.x = dot(r3.xy, r3.xy);
    r4.x = max(9.99999994e-09, r4.x);
    r4.x = sqrt(r4.x);
    r4.xyzw = r3.xyxy / r4.xxxx;
    r4.xyzw = r4.xyzw * r3.zzzz;
    r4.xyzw = r4.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
    r3.xy = float2(126.732674,126.732674) * r4.zw;
    r5.xy = cmp(r3.xy >= -r3.xy);
    r3.xy = frac(abs(r3.xy));
    r3.xy = r5.xy ? r3.xy : -r3.xy;
    r5.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r4.zw, 0).xyzw;
    r4.xyzw = -r3.xyxy * float4(0.00789062493,0.00789062493,0.00789062493,0.00789062493) + r4.xyzw;
    r6.xyzw = float4(0.00789062493,0,0,0.00789062493) + r4.zwzw;
    r7.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r6.xy, 0).xyzw;
    r6.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r6.zw, 0).xyzw;
    r8.xyzw = float4(0.00789062493,0.00789062493,-0.5,-0.5) + r4.zwzw;
    r9.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r8.xy, 0).xyzw;
    r8.xy = float2(1,1) + -r3.xy;
    r10.xyz = r8.xxx * r5.xyz;
    r11.xyz = r7.xyz * r3.xxx;
    r11.xyz = r11.xyz * r8.yyy;
    r10.xyz = r10.xyz * r8.yyy + r11.xyz;
    r11.xyz = r8.xxx * r6.xyz;
    r10.xyz = r11.xyz * r3.yyy + r10.xyz;
    r9.xyz = r9.xyz * r3.xxx;
    r3.xyz = r9.xyz * r3.yyy + r10.xyz;
    r3.w = r3.w / BoundRadius;
    r3.w = min(1, r3.w);
    r3.xyz = r3.xyz * r3.www;
    r3.xyz = DamageMultiplier * r3.xyz;
    r0.xyz = r3.xyz * v1.www + r0.xyz;
    r3.x = cmp(0 < DamagedWheelOffsets[0].w);
    r9.xyz = DamagedWheelOffsets[0].xyz + -DamageTextureOffset.xyz;
    r9.xzw = -r9.xyz + r0.xyz;
    r3.y = dot(r9.xzw, r9.xzw);
    r3.y = sqrt(r3.y);
    r3.z = 1.10000002 * DamagedWheelOffsets[0].w;
    r5.w = saturate(r3.y / r3.z);
    r6.w = cmp(r5.w < 1);
    r3.y = r9.z / r3.y;
    r5.w = r5.w * 0.100000001 + 0.899999976;
    r3.y = r5.w * r3.y;
    r3.y = r3.y * r3.z + r9.y;
    r3.y = r6.w ? r3.y : r0.y;
    r0.w = r3.x ? r3.y : r0.y;
    r3.x = cmp(0 < DamagedWheelOffsets[1].w);
    r9.xyz = DamagedWheelOffsets[1].xyz + -DamageTextureOffset.xyz;
    r9.xzw = -r9.xyz + r0.xwz;
    r3.y = dot(r9.xzw, r9.xzw);
    r3.y = sqrt(r3.y);
    r3.z = 1.10000002 * DamagedWheelOffsets[1].w;
    r5.w = saturate(r3.y / r3.z);
    r6.w = cmp(r5.w < 1);
    r3.y = r9.z / r3.y;
    r5.w = r5.w * 0.100000001 + 0.899999976;
    r3.y = r5.w * r3.y;
    r3.y = r3.y * r3.z + r9.y;
    r3.y = r6.w ? r3.y : r0.w;
    r0.y = r3.x ? r3.y : r0.w;
    r3.xy = r8.zw + r8.zw;
    r0.w = dot(r3.xy, r3.xy);
    r3.z = cmp(0 < r0.w);
    r0.w = sqrt(r0.w);
    r0.w = r3.z ? r0.w : 0;
    r3.z = -r0.w * 2 + 1;
    r8.z = max(-1, r3.z);
    r3.z = cmp(r8.z < 1);
    r5.w = cmp(-1 < r8.z);
    r3.z = r3.z ? r5.w : 0;
    r5.w = cmp(0 < r0.w);
    r3.z = r3.z ? r5.w : 0;
    r5.w = -r8.z * r8.z + 1;
    r5.w = sqrt(r5.w);
    r0.w = r5.w / r0.w;
    r0.w = r3.z ? r0.w : 0;
    r8.xy = r3.xy * r0.ww;
    r3.xyz = r5.xyz * r3.www;
    r3.xyz = DamageMultiplier * r3.xyz;
    r4.xyzw = float4(-0.492109388,-0.5,-0.5,-0.492109388) + r4.xyzw;
    r4.xyzw = r4.xyzw + r4.xyzw;
    r0.w = dot(r4.xy, r4.xy);
    r5.x = cmp(0 < r0.w);
    r0.w = sqrt(r0.w);
    r0.w = r5.x ? r0.w : 0;
    r5.x = -r0.w * 2 + 1;
    r5.z = max(-1, r5.x);
    r5.w = cmp(r5.z < 1);
    r6.w = cmp(-1 < r5.z);
    r5.w = r5.w ? r6.w : 0;
    r6.w = cmp(0 < r0.w);
    r5.w = r5.w ? r6.w : 0;
    r6.w = -r5.z * r5.z + 1;
    r6.w = sqrt(r6.w);
    r0.w = r6.w / r0.w;
    r0.w = r5.w ? r0.w : 0;
    r5.xy = r4.xy * r0.ww;
    r7.xyz = r7.xyz * r3.www;
    r5.xyz = r5.xyz + -r8.xyz;
    r7.xyz = r7.xyz * DamageMultiplier + -r3.xyz;
    r0.w = dot(r7.xyz, r1.yzw);
    r4.x = dot(r5.xyz, r5.xyz);
    r4.y = cmp(0 < r4.x);
    r7.x = r0.w / r4.x;
    r7.y = 1;
    r5.xyz = r7.xyx * r5.xyz;
    r7.yz = v1.ww;
    r5.xyz = r7.zxz * r5.xyz;
    r7.xz = float2(0.100000001,0.333299994);
    r5.xyz = r5.xyz * r7.xyz + r1.yzw;
    r5.xyz = r4.yyy ? r5.xyz : r1.yzw;
    r0.w = dot(r4.zw, r4.zw);
    r4.x = cmp(0 < r0.w);
    r0.w = sqrt(r0.w);
    r0.w = r4.x ? r0.w : 0;
    r4.x = -r0.w * 2 + 1;
    r9.z = max(-1, r4.x);
    r4.x = cmp(r9.z < 1);
    r4.y = cmp(-1 < r9.z);
    r4.x = r4.y ? r4.x : 0;
    r4.y = cmp(0 < r0.w);
    r4.x = r4.y ? r4.x : 0;
    r4.y = -r9.z * r9.z + 1;
    r4.y = sqrt(r4.y);
    r0.w = r4.y / r0.w;
    r0.w = r4.x ? r0.w : 0;
    r9.xy = r4.zw * r0.ww;
    r4.xyz = r6.xyz * r3.www;
    r6.xyz = r9.xyz + -r8.xyz;
    r3.xyz = r4.xyz * DamageMultiplier + -r3.xyz;
    r0.w = dot(r3.xyz, r1.yzw);
    r3.x = dot(r6.xyz, r6.xyz);
    r3.y = cmp(0 < r3.x);
    r4.x = r0.w / r3.x;
    r4.y = 1;
    r3.xzw = r4.xyx * r6.xyz;
    r4.z = v1.w;
    r3.xzw = r4.zxz * r3.xzw;
    r3.xzw = r3.xzw * r7.xyz + r5.xyz;
    r3.xyz = r3.yyy ? r3.xzw : r5.xyz;
    r3.xyz = float3(9.99999975e-05,9.99999975e-05,9.99999975e-05) + r3.xyz;
    r0.w = dot(r3.xyz, r3.xyz);
    r0.w = rsqrt(r0.w);
    r1.yzw = r3.xyz * r0.www;
  }
  r3.xyz = gWorld._m10_m11_m12 * r0.yyy;
  r3.xyz = r0.xxx * gWorld._m00_m01_m02 + r3.xyz;
  r3.xyz = r0.zzz * gWorld._m20_m21_m22 + r3.xyz;
  r3.xyz = gWorld._m30_m31_m32 + r3.xyz;
  r4.xyz = gViewInverse._m30_m31_m32 + -r3.xyz;
  r0.w = dot(r1.yzw, r1.yzw);
  r0.w = cmp(r0.w < 0.100000001);
  r1.yzw = r0.www ? float3(0,0,1) : r1.yzw;
  r5.xyz = gWorld._m10_m11_m12 * r1.zzz;
  r5.xyz = r1.yyy * gWorld._m00_m01_m02 + r5.xyz;
  r1.yzw = r1.www * gWorld._m20_m21_m22 + r5.xyz;
  r0.w = dot(r1.yzw, r1.yzw);
  r0.w = rsqrt(r0.w);
  r1.yzw = r1.yzw * r0.www;
  r5.xyz = gWorld._m10_m11_m12 * r2.yyy;
  r5.xyz = r2.xxx * gWorld._m00_m01_m02 + r5.xyz;
  r2.xyz = r2.zzz * gWorld._m20_m21_m22 + r5.xyz;
  r5.xyz = r2.zxy * r1.zwy;
  r5.xyz = r2.yzx * r1.wyz + -r5.xyz;
  r5.xyz = r5.xyz * r2.www;
  o6.x = dot(r2.xyz, r4.xyz);
  o6.y = dot(r5.xyz, r4.xyz);
  o6.z = dot(r1.yzw, r4.xyz);
  r4.xyz = gViewInverse._m30_m31_m32 + -gWorld._m30_m31_m32;
  r6.x = dot(gWorld._m00_m01_m02, r4.xyz);
  r6.y = dot(gWorld._m10_m11_m12, r4.xyz);
  r6.z = dot(gWorld._m20_m21_m22, r4.xyz);
  r4.xyz = r6.xyz + -r0.xyz;
  r0.w = dot(r4.xyz, r4.xyz);
  r0.w = rsqrt(r0.w);
  r4.xyz = r4.xyz * r0.www;
  r0.xyz = r4.xyz * zShiftScale + r0.xyz;
  r4.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r4.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r4.xyzw;
  r0.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r4.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o0.xy = saturate(gPerInstCBuf[r1.x].vertexColor.xy);
  o8.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o0.z = gPerInstCBuf[r1.x].vertexColor.z;
  o5.xyz = r3.xyz;
  o5.w = 1;
  o6.w = 1;
  o7.xyzw = r0.xyzw;
  o8.yzw = float3(0,0,0);
  o1.z = r0.w;
  o2.xyz = r1.yzw;
  o3.xyz = r2.xyz;
  o4.xyz = r5.xyz;
  return;
}