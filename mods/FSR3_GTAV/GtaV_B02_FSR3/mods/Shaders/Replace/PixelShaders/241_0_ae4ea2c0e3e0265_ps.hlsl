// ---- FNV Hash ae4ea2c0e3e0265

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer _Globals : register(b0)
{
  float4 Timer : packoffset(c0);
  float4 tempF1 : packoffset(c1);
  float4 tempF2 : packoffset(c2);
  float4 tempF3 : packoffset(c3);
  float4 ScreenSize : packoffset(c4);
  float4 SourceSize : packoffset(c5);
  float4 Parameters01 : packoffset(c6);
  float4 Parameters02 : packoffset(c7);
  float4 Parameters03 : packoffset(c8);
  float4 Parameters04 : packoffset(c9);
  float4 Parameters05 : packoffset(c10);
  float4 ParamsArray01[16] : packoffset(c11);
  float4 Matrix01[4] : packoffset(c27);
  float4 Matrix02[4] : packoffset(c31);
  float4 Matrix03[4] : packoffset(c35);
  float4 Matrix04[4] : packoffset(c39);
  float4 Matrix05[4] : packoffset(c43);
  float4x4 tmatrix01 : packoffset(c47);
  float4x4 tmatrix02 : packoffset(c51);
  float4 tmatrix03[4] : packoffset(c55);
  float4 tmatrix04[4] : packoffset(c59);
  float OCEANSHORE_DynamicFoamShift : packoffset(c63) = {0.150000006};
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

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
}

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
}

cbuffer water_globals : register(b4)
{
  float2 gWorldBaseVS : packoffset(c0);
  float4 gFlowParams : packoffset(c1);
  float4 gFlowParams2 : packoffset(c2);
  float4 gWaterAmbientColor : packoffset(c3);
  float4 gWaterDirectionalColor : packoffset(c4);
  float4 gScaledTime : packoffset(c5);
  float4 gOceanParams0 : packoffset(c6);
  float4 gOceanParams1 : packoffset(c7);
  row_major float4x4 gReflectionWorldViewProj : packoffset(c8);
  float4 gFogLight_Debugging : packoffset(c12);
  row_major float4x4 gRefractionWorldViewProj : packoffset(c13);
  float4 gOceanParams2 : packoffset(c17);
}

SamplerState Sampler2_s : register(s2);
SamplerState Sampler4_s : register(s4);
SamplerState Sampler6_s : register(s6);
SamplerState Sampler7_s : register(s7);
SamplerState Sampler9_s : register(s9);
SamplerState Sampler10_s : register(s10);
SamplerState Sampler12_s : register(s12);
Texture2D<float4> Texture2 : register(t2);
Texture2D<float4> Texture4 : register(t4);
Texture2D<float4> Texture6 : register(t6);
Texture2D<float4> Texture7 : register(t7);
Texture2D<float4> Texture9 : register(t9);
Texture2D<float4> Texture10 : register(t10);
Texture2D<float4> Texture12 : register(t12);
Texture2D<float4> Texture14 : register(t14);
Texture2D<float4> Texture15 : register(t15);
Texture2D<float4> Texture17 : register(t17);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = tempF1.z * tempF1.z;
  r0.x = r0.x * r0.x;
  r0.yz = gOceanParams0.yy * v3.xy;
  r1.xy = float2(3.70000005,3.70000005) * r0.yz;
  r2.xyzw = Texture14.Sample(Sampler10_s, r0.yz).xyzw;
  r3.xyzw = Texture14.SampleLevel(Sampler10_s, r1.xy, 0).xyzw;
  r3.xyzw = r3.xyxy * float4(2,2,2,2) + float4(-1,-1,-1,-1);
  r0.xyzw = r3.xyzw * r0.xxxx + r1.xyxy;
  r1.xyzw = Texture10.Sample(Sampler10_s, r1.xy).xyzw;
  r2.zw = r1.xy;
  r1.xyzw = r2.xyzw * float4(2,2,2,2) + float4(-1,-1,-1,-1);
  r1.xy = r1.xy + r1.zw;
  r2.xyzw = float4(-0.001953125,0,0.001953125,0) + r0.zwzw;
  r3.xyzw = Texture17.Sample(Sampler10_s, r2.xy).xyzw;
  r2.xyzw = Texture17.Sample(Sampler10_s, r2.zw).xyzw;
  r3.y = r2.x;
  r2.xyzw = float4(0,-0.001953125,0,0.001953125) + r0.xyzw;
  r0.xyzw = Texture17.Sample(Sampler10_s, r0.zw).xyzw;
  r4.xyzw = Texture17.Sample(Sampler10_s, r2.xy).xyzw;
  r2.xyzw = Texture17.Sample(Sampler10_s, r2.zw).xyzw;
  r3.w = r2.x;
  r3.z = r4.x;
  r0.xyzw = -r3.xyzw + r0.xxxx;
  r2.xyzw = float4(-1,0,1,0) * r0.xxyy;
  r0.xy = r2.xy + r2.zw;
  r0.xy = r0.zz * float2(0,-1) + r0.xy;
  r0.xy = r0.ww * float2(0,1) + r0.xy;
  r0.z = tempF2.x * tempF2.x;
  r0.xy = r0.xy * r0.zz;
  r0.z = 1;
  r0.z = dot(r0.xyz, r0.xyz);
  r0.z = rsqrt(r0.z);
  r0.xy = r0.xy * r0.zz + r1.xy;
  r0.z = gScaledTime.x * 0.100000001;
  r1.xy = v3.xy * float2(0.00195309997,0.00195309997) + -r0.zz;
  r0.zw = v3.yx * float2(0.00223210012,0.00223210012) + r0.zz;
  r2.xyzw = Texture2.Sample(Sampler2_s, r0.zw).xyzw;
  r0.zw = r2.yw * float2(2,2) + float2(-1,-1);
  r1.xyzw = Texture2.Sample(Sampler2_s, r1.xy).xyzw;
  r1.xy = r1.wy * float2(2,2) + float2(-1,-1);
  r0.zw = -r1.xy + -r0.zw;
  r0.xy = r0.zw * gOceanParams1.ww + r0.xy;
  r1.xy = r0.xy * gOceanParams0.xx + v2.xy;
  r0.x = dot(r0.xy, r0.xy);
  r0.x = sqrt(r0.x);
  r0.x = r0.x * 0.270000011 + 0.439999998;
  r1.z = v2.z;
  r0.y = dot(r1.xyz, r1.xyz);
  r0.y = rsqrt(r0.y);
  r2.xyz = -r1.xyz * r0.yyy + float3(0,0,1);
  r0.yzw = r1.xyz * r0.yyy;
  r1.xyz = r2.xyz * float3(0.833333313,0.833333313,0.833333313) + r0.yzw;
  r2.xyz = -gViewInverse._m30_m31_m32 + v3.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r3.xyz = r2.xyz * r1.www;
  r2.w = dot(r3.xyz, r1.xyz);
  r2.w = r2.w + r2.w;
  r1.xyz = r1.xyz * -r2.www + r3.xyz;
  r2.w = dot(-r3.xyz, r0.yzw);
  r1.z = -r2.z * r1.w + -r1.z;
  r1.z = -r2.z * r1.w + abs(r1.z);
  r3.xyz = gReflectionWorldViewProj._m10_m13_m11 * r1.yyy;
  r3.xyz = r1.xxx * gReflectionWorldViewProj._m00_m03_m01 + r3.xyz;
  r1.xyz = r1.zzz * gReflectionWorldViewProj._m20_m23_m21 + r3.xyz;
  r3.xyz = float3(0.5,0.5,0.5) * r1.xyz;
  r4.y = r1.y * 0.5 + -r3.z;
  r4.x = r3.x + r3.y;
  r1.xy = r4.xy / r1.yy;
  r3.xyzw = Texture7.Sample(Sampler7_s, r1.xy).xyzw;
  r4.xyzw = Texture4.Sample(Sampler4_s, v4.zw).xyzw;
  r0.x = r4.y * r0.x;
  r4.xyzw = Texture9.Sample(Sampler9_s, v1.zw).xyzw;
  r1.x = 0.649999976 * r4.x;
  r1.y = 512 + -v3.w;
  r1.y = saturate(0.00195309997 * r1.y);
  r1.x = r1.x * r1.y;
  r4.x = r0.x * 0.349999994 + r1.x;
  r4.yw = float2(0.5,0.5);
  r5.xyzw = Texture6.Sample(Sampler6_s, r4.xy).xyzw;
  r1.xy = -r0.yz;
  r1.z = 0;
  r1.xyz = r2.xyz * r1.www + r1.xyz;
  r2.xyz = r2.xyz * r1.www + gDirectionalLight.xyz;
  r6.xy = v1.xy / v3.ww;
  r7.xyzw = Texture15.Sample(Sampler6_s, r6.xy).xyzw;
  r1.xyz = r1.xyz * r7.yyy + v3.xyz;
  r6.z = r7.y;
  r5.xzw = gRefractionWorldViewProj._m10_m13_m11 * r1.yyy;
  r1.xyw = r1.xxx * gRefractionWorldViewProj._m00_m03_m01 + r5.xzw;
  r1.xyz = r1.zzz * gRefractionWorldViewProj._m20_m23_m21 + r1.xyw;
  r1.xyz = gRefractionWorldViewProj._m30_m33_m31 + r1.xyz;
  r1.xzw = float3(0.5,0.5,0.5) * r1.xyz;
  r4.y = r1.y * 0.5 + -r1.w;
  r4.x = r1.x + r1.z;
  r1.xy = r4.xy / r1.yy;
  r7.xyzw = Texture15.Sample(Sampler6_s, r1.xy).xyzw;
  r0.x = cmp(0.000000 != r7.z);
  r1.z = r7.y;
  r1.xyz = r0.xxx ? r6.xyz : r1.xyz;
  r0.x = r5.y * r1.z;
  r5.xyzw = Texture12.Sample(Sampler12_s, r1.xy).xyzw;
  r1.x = dot(r0.yzw, -gDirectionalLight.xyz);
  r1.x = saturate(r1.x * 0.699999988 + 0.300000012);
  r1.xyw = gWaterDirectionalColor.xyz * r1.xxx;
  r1.xyw = r1.xyw * r7.www + gWaterAmbientColor.xyz;
  r1.xyw = r1.xyw * r0.xxx + r5.xyz;
  r3.xyz = r3.xyz + -r1.xyw;
  r0.x = 1 + -r2.w;
  r4.z = r0.x * 0.300000012 + r2.w;
  r4.xyzw = Texture6.Sample(Sampler6_s, r4.zw).xyzw;
  r3.xyz = r4.xxx * r3.xyz + r1.xyw;
  r0.x = dot(r2.xyz, r2.xyz);
  r0.x = rsqrt(r0.x);
  r2.xyz = r2.xyz * r0.xxx;
  r0.x = saturate(dot(-r2.xyz, r0.yzw));
  r0.x = log2(r0.x);
  r0.x = gOceanParams0.w * r0.x;
  r0.x = exp2(r0.x);
  r0.x = gOceanParams0.z * r0.x;
  r0.x = r0.x * r7.w;
  r0.xyz = gWaterDirectionalColor.xyz * r0.xxx + r3.xyz;
  r0.xyz = r0.xyz + -r1.xyw;
  r0.xyz = r1.zzz * r0.xyz + r1.xyw;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  o0.w = 0;
  return;
}