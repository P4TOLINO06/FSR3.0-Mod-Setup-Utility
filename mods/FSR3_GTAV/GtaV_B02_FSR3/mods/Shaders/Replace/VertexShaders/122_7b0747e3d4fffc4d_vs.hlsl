// ---- FNV Hash 7b0747e3d4fffc4d

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 21:49:46 2023

cbuffer rage_bonemtx : register(b4)
{
  row_major float3x4 gBoneMtx[255] : packoffset(c0);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer vehicle_globals : register(b7)
{
  bool switchOn : packoffset(c0);
  bool tyreDeformSwitchOn : packoffset(c0.y);
}

cbuffer vehicle_damage_locals : register(b12)
{
  float BoundRadius : packoffset(c0);
  float DamageMultiplier : packoffset(c0.y);
  float3 DamageTextureOffset : packoffset(c1);
  float4 DamagedWheelOffsets[2] : packoffset(c2);
  bool bDebugDisplayDamageMap : packoffset(c4);
  bool bDebugDisplayDamageScale : packoffset(c4.y);
}

cbuffer vehiclecommonlocals : register(b11)
{
  float DiffuseTexTileUV : packoffset(c0);
  float3 matDiffuseColor : packoffset(c0.y);
  float matDiffuseSpecularRampEnabled : packoffset(c1);
  float4 matDiffuseColor2 : packoffset(c2);
  float4 dirtLevelMod : packoffset(c3);
  float3 dirtColor : packoffset(c4);
  float specularFresnel : packoffset(c4.w);
  float specularFalloffMult : packoffset(c5);
  float specularIntensityMult : packoffset(c5.y);
  float3 specMapIntMask : packoffset(c6);
  float specTexTileUV : packoffset(c6.w);
  float4 specular2Color_DirLerp : packoffset(c7);
  float reflectivePower : packoffset(c8);
  float diffuse2SpecMod : packoffset(c8.y);
  float envEffThickness : packoffset(c8.z);
  float2 envEffScale : packoffset(c9);
  float envEffTexTileUV : packoffset(c9.z);
}

SamplerState DamageSampler_s : register(s2);
Texture2D<float4> DamageSampler : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float4 v3 : TEXCOORD0,
  float2 v4 : TEXCOORD1,
  float3 v5 : NORMAL0,
  float4 v6 : COLOR0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.z
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyzw
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = saturate(v6.w);
  if (switchOn != 0) {
    r0.yzw = DamageTextureOffset.xyz + v0.xyz;
    r1.x = dot(r0.yzw, r0.yzw);
    r1.x = sqrt(r1.x);
    r0.yzw = r0.yzw / r1.xxx;
    r0.w = 1 + -r0.w;
    r0.w = 0.5 * r0.w;
    r1.y = dot(r0.yz, r0.yz);
    r1.y = max(9.99999994e-09, r1.y);
    r1.y = sqrt(r1.y);
    r2.xyzw = r0.yzyz / r1.yyyy;
    r2.xyzw = r2.xyzw * r0.wwww;
    r2.xyzw = r2.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
    r0.yz = float2(126.732674,126.732674) * r2.zw;
    r1.yz = cmp(r0.yz >= -r0.yz);
    r0.yz = frac(abs(r0.yz));
    r0.yz = r1.yz ? r0.yz : -r0.yz;
    r3.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r2.zw, 0).xyzw;
    r2.xyzw = -r0.yzyz * float4(0.00789062493,0.00789062493,0.00789062493,0.00789062493) + r2.xyzw;
    r4.xyzw = float4(0.00789062493,0,0,0.00789062493) + r2.zwzw;
    r5.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r4.xy, 0).xyzw;
    r4.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r4.zw, 0).xyzw;
    r6.xyzw = float4(0.00789062493,0.00789062493,-0.5,-0.5) + r2.zwzw;
    r7.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r6.xy, 0).xyzw;
    r1.yz = float2(1,1) + -r0.yz;
    r8.xyz = r3.xyz * r1.yyy;
    r9.xyz = r5.xyz * r0.yyy;
    r9.xyz = r9.xyz * r1.zzz;
    r8.xyz = r8.xyz * r1.zzz + r9.xyz;
    r1.yzw = r4.xyz * r1.yyy;
    r1.yzw = r1.yzw * r0.zzz + r8.xyz;
    r7.xyz = r7.xyz * r0.yyy;
    r0.yzw = r7.xyz * r0.zzz + r1.yzw;
    r1.x = r1.x / BoundRadius;
    r1.x = min(1, r1.x);
    r0.yzw = r1.xxx * r0.yzw;
    r0.yzw = DamageMultiplier * r0.yzw;
    r1.y = dot(r0.yzw, r0.yzw);
    r1.y = sqrt(r1.y);
    r1.y = min(1, r1.y);
    r1.y = -r1.y * 4 + 1;
    o2.w = max(0, r1.y);
    r7.xyz = r0.yzw * v6.yyy + v0.xyz;
    r0.y = cmp(0 < DamagedWheelOffsets[0].w);
    r1.yzw = DamagedWheelOffsets[0].xyz + -DamageTextureOffset.xyz;
    r8.xyz = r7.xyz + -r1.yzw;
    r0.z = dot(r8.xyz, r8.xyz);
    r0.z = sqrt(r0.z);
    r0.w = 1.10000002 * DamagedWheelOffsets[0].w;
    r1.y = saturate(r0.z / r0.w);
    r1.w = cmp(r1.y < 1);
    r0.z = r8.y / r0.z;
    r1.y = r1.y * 0.100000001 + 0.899999976;
    r0.z = r1.y * r0.z;
    r0.z = r0.z * r0.w + r1.z;
    r0.z = r1.w ? r0.z : r7.y;
    r7.w = r0.y ? r0.z : r7.y;
    r0.y = cmp(0 < DamagedWheelOffsets[1].w);
    r1.yzw = DamagedWheelOffsets[1].xyz + -DamageTextureOffset.xyz;
    r8.xyz = r7.xwz + -r1.yzw;
    r0.z = dot(r8.xyz, r8.xyz);
    r0.z = sqrt(r0.z);
    r0.w = 1.10000002 * DamagedWheelOffsets[1].w;
    r1.y = saturate(r0.z / r0.w);
    r1.w = cmp(r1.y < 1);
    r0.z = r8.y / r0.z;
    r1.y = r1.y * 0.100000001 + 0.899999976;
    r0.z = r1.y * r0.z;
    r0.z = r0.z * r0.w + r1.z;
    r0.z = r1.w ? r0.z : r7.w;
    r7.y = r0.y ? r0.z : r7.w;
    r0.yz = r6.zw + r6.zw;
    r0.w = dot(r0.yz, r0.yz);
    r1.y = cmp(0 < r0.w);
    r0.w = sqrt(r0.w);
    r0.w = r1.y ? r0.w : 0;
    r1.y = -r0.w * 2 + 1;
    r6.z = max(-1, r1.y);
    r1.y = cmp(r6.z < 1);
    r1.z = cmp(-1 < r6.z);
    r1.y = r1.z ? r1.y : 0;
    r1.z = cmp(0 < r0.w);
    r1.y = r1.z ? r1.y : 0;
    r1.z = -r6.z * r6.z + 1;
    r1.z = sqrt(r1.z);
    r0.w = r1.z / r0.w;
    r0.w = r1.y ? r0.w : 0;
    r6.xy = r0.yz * r0.ww;
    r0.yzw = r3.xyz * r1.xxx;
    r0.yzw = DamageMultiplier * r0.yzw;
    r2.xyzw = float4(-0.492109388,-0.5,-0.5,-0.492109388) + r2.xyzw;
    r2.xyzw = r2.xyzw + r2.xyzw;
    r1.y = dot(r2.xy, r2.xy);
    r1.z = cmp(0 < r1.y);
    r1.y = sqrt(r1.y);
    r1.y = r1.z ? r1.y : 0;
    r1.z = -r1.y * 2 + 1;
    r3.z = max(-1, r1.z);
    r1.z = cmp(r3.z < 1);
    r1.w = cmp(-1 < r3.z);
    r1.z = r1.w ? r1.z : 0;
    r1.w = cmp(0 < r1.y);
    r1.z = r1.w ? r1.z : 0;
    r1.w = -r3.z * r3.z + 1;
    r1.w = sqrt(r1.w);
    r1.y = r1.w / r1.y;
    r1.y = r1.z ? r1.y : 0;
    r3.xy = r2.xy * r1.yy;
    r1.yzw = r5.xyz * r1.xxx;
    r3.xyz = r3.xyz + -r6.xyz;
    r1.yzw = r1.yzw * DamageMultiplier + -r0.yzw;
    r1.y = dot(r1.yzw, v5.xyz);
    r1.z = dot(r3.xyz, r3.xyz);
    r1.w = cmp(0 < r1.z);
    r5.x = r1.y / r1.z;
    r5.y = 1;
    r3.xyz = r5.xyx * r3.xyz;
    r5.yz = v6.yy;
    r3.xyz = r5.zxz * r3.xyz;
    r5.xz = float2(0.100000001,0.333299994);
    r3.xyz = r3.xyz * r5.xyz + v5.xyz;
    r1.yzw = r1.www ? r3.xyz : v5.xyz;
    r2.x = dot(r2.zw, r2.zw);
    r2.y = cmp(0 < r2.x);
    r2.x = sqrt(r2.x);
    r2.x = r2.y ? r2.x : 0;
    r2.y = -r2.x * 2 + 1;
    r3.z = max(-1, r2.y);
    r2.y = cmp(r3.z < 1);
    r3.w = cmp(-1 < r3.z);
    r2.y = r2.y ? r3.w : 0;
    r3.w = cmp(0 < r2.x);
    r2.y = r2.y ? r3.w : 0;
    r3.w = -r3.z * r3.z + 1;
    r3.w = sqrt(r3.w);
    r2.x = r3.w / r2.x;
    r2.x = r2.y ? r2.x : 0;
    r3.xy = r2.zw * r2.xx;
    r2.xyz = r4.xyz * r1.xxx;
    r3.xyz = r3.xyz + -r6.xyz;
    r0.yzw = r2.xyz * DamageMultiplier + -r0.yzw;
    r0.y = dot(r0.yzw, v5.xyz);
    r0.z = dot(r3.xyz, r3.xyz);
    r0.w = cmp(0 < r0.z);
    r2.x = r0.y / r0.z;
    r2.y = 1;
    r3.xyz = r2.xyx * r3.xyz;
    r2.z = v6.y;
    r2.xyz = r3.xyz * r2.zxz;
    r2.xyz = r2.xyz * r5.xyz + r1.yzw;
    r0.yzw = r0.www ? r2.xyz : r1.yzw;
    r0.yzw = float3(9.99999975e-05,9.99999975e-05,9.99999975e-05) + r0.yzw;
    r1.x = dot(r0.yzw, r0.yzw);
    r1.x = rsqrt(r1.x);
    r0.yzw = r1.xxx * r0.yzw;
  } else {
    r7.xyz = v0.xyz;
    r0.yzw = v5.xyz;
    o2.w = 1;
  }
  r1.x = 255.001953 * v2.z;
  r1.x = (int)r1.x;
  r1.x = (int)r1.x * 3;
  r7.w = 1;
  r1.y = dot(gBoneMtx[r1.x/3]._m00_m01_m02_m03, r7.xyzw);
  r1.z = dot(gBoneMtx[r1.x/3]._m10_m11_m12_m13, r7.xyzw);
  r1.w = dot(gBoneMtx[r1.x/3]._m20_m21_m22_m23, r7.xyzw);
  r2.xyz = gWorld._m10_m11_m12 * r1.zzz;
  r2.xyz = r1.yyy * gWorld._m00_m01_m02 + r2.xyz;
  r2.xyz = r1.www * gWorld._m20_m21_m22 + r2.xyz;
  r2.xyz = gWorld._m30_m31_m32 + r2.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r2.xyz;
  r2.x = dot(gBoneMtx[r1.x/3]._m00_m01_m02, r0.yzw);
  r2.y = dot(gBoneMtx[r1.x/3]._m10_m11_m12, r0.yzw);
  r0.y = dot(gBoneMtx[r1.x/3]._m20_m21_m22, r0.yzw);
  r2.yzw = gWorld._m10_m11_m12 * r2.yyy;
  r2.xyz = r2.xxx * gWorld._m00_m01_m02 + r2.yzw;
  o2.xyz = r0.yyy * gWorld._m20_m21_m22 + r2.xyz;
  float3 temp = float3(r1.y, r1.z, r1.w);
  pos.xyzw = float4(temp.xyz, 1);
  r2.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.zzzz;
  r2.xyzw = r1.yyyy * gWorldViewProj._m00_m01_m02_m03 + r2.xyzw;
  r1.xyzw = r1.wwww * gWorldViewProj._m20_m21_m22_m23 + r2.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r1.xyzw;
  if (bDebugDisplayDamageMap != 0) {
    r0.yzw = DamageTextureOffset.xyz + v0.xyz;
    r1.x = dot(r0.yzw, r0.yzw);
    r1.x = sqrt(r1.x);
    r0.yzw = r0.yzw / r1.xxx;
    r0.w = 1 + -r0.w;
    r0.w = 0.5 * r0.w;
    r1.y = dot(r0.yz, r0.yz);
    r1.y = max(9.99999994e-09, r1.y);
    r1.y = sqrt(r1.y);
    r0.yz = r0.yz / r1.yy;
    r0.yz = r0.yz * r0.ww;
    r0.yz = r0.yz * float2(0.5,0.5) + float2(0.5,0.5);
    r1.yz = float2(126.732674,126.732674) * r0.yz;
    r2.xy = cmp(r1.yz >= -r1.yz);
    r1.yz = frac(abs(r1.yz));
    r1.yz = r2.xy ? r1.yz : -r1.yz;
    r2.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r0.yz, 0).xyzw;
    r0.yz = -r1.yz * float2(0.00789062493,0.00789062493) + r0.yz;
    r3.xyzw = float4(0.00789062493,0,0,0.00789062493) + r0.yzyz;
    r4.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.xy, 0).xyzw;
    r3.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.zw, 0).xyzw;
    r0.yz = float2(0.00789062493,0.00789062493) + r0.yz;
    r5.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r0.yz, 0).xyzw;
    r0.yz = float2(1,1) + -r1.yz;
    r2.xyzw = r2.xyzw * r0.yyyy;
    r4.xyzw = r4.xyzw * r1.yyyy;
    r4.xyzw = r4.xyzw * r0.zzzz;
    r2.xyzw = r2.xyzw * r0.zzzz + r4.xyzw;
    r3.xyzw = r3.xyzw * r0.yyyy;
    r2.xyzw = r3.xyzw * r1.zzzz + r2.xyzw;
    r3.xyzw = r5.xyzw * r1.yyyy;
    r2.xyzw = r3.xyzw * r1.zzzz + r2.xyzw;
    r0.y = r1.x / BoundRadius;
    r0.y = min(1, r0.y);
    r1.xyzw = r2.xyzw * r0.yyyy;
    r1.xyzw = r1.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
  } else {
    r1.xyzw = v6.xyzw;
  }
  r2.x = v6.y;
  r2.w = 1;
  o3.xyzw = bDebugDisplayDamageScale ? r2.xxxw : r1.xyzw;
  o4.w = envEffScale.x * r0.x;
  o1.xy = v3.xy;
  o1.zw = v4.xy;
  return;
}