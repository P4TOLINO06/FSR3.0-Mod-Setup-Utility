// ---- FNV Hash 132f0a253d533c72

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

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

cbuffer more_stuff : register(b5)
{
  float4 gEntitySelectColor[2] : packoffset(c0);
  float4 gAmbientOcclusionEffect : packoffset(c2);
  float4 gDynamicBakesAndWetness : packoffset(c3);
  float4 gAlphaRefVec0 : packoffset(c4);
  float4 gAlphaRefVec1 : packoffset(c5);
  float gAlphaTestRef : packoffset(c6);
  bool gTreesUseDiscard : packoffset(c6.y);
  float gReflectionMipCount : packoffset(c6.z);
  float gTransparencyAASamples : packoffset(c6.w);
  bool gUseFogRay : packoffset(c7);
}

cbuffer vehiclecommonlocals : register(b11)
{
  float4 matDiffuseColor2 : packoffset(c0);
  float4 matDiffuseColorTint : packoffset(c1);
  float4 dirtLevelMod : packoffset(c2);
  float3 dirtColor : packoffset(c3);
  float3 specMapIntMask : packoffset(c4);
  float reflectivePower : packoffset(c4.w);
  float envEffThickness : packoffset(c5);
  float2 envEffScale : packoffset(c5.y);
  float envEffTexTileUV : packoffset(c5.w);
  float4 vehglassCrackTextureParams[2] : packoffset(c6);
}

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
}

SamplerState DiffuseSampler_s : register(s0);
SamplerState ReflectionSampler_s : register(s1);
SamplerState DirtSampler_s : register(s3);
SamplerState SpecSampler_s : register(s4);
SamplerState vehglassCrackTextureSampler_s : register(s5);
SamplerState FogRaySampler_s : register(s11);
SamplerComparisonState gShadowZSamplerCache_s : register(s14);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> DirtSampler : register(t3);
Texture2D<float4> SpecSampler : register(t4);
Texture2D<float4> vehglassCrackTextureSampler : register(t5);
Texture2D<float4> FogRaySampler : register(t11);
TextureCube<float4> gLocalLightShadowCM0 : register(t14);
Texture2D<float4> gCSMShadowTexture : register(t15);
Texture2D<float> gLocalLightShadowSpot0 : register(t24);
TextureCube<float> gLocalLightShadowCM1 : register(t25);
Texture2D<float> gLocalLightShadowSpot1 : register(t26);
TextureCube<float> gLocalLightShadowCM2 : register(t27);
Texture2D<float> gLocalLightShadowSpot2 : register(t28);
TextureCube<float> gLocalLightShadowCM3 : register(t29);
Texture2D<float> gLocalLightShadowSpot3 : register(t30);
TextureCube<float> gLocalLightShadowCM4 : register(t31);
Texture2D<float> gLocalLightShadowSpot4 : register(t32);
TextureCube<float> gLocalLightShadowCM5 : register(t33);
Texture2D<float> gLocalLightShadowSpot5 : register(t34);
TextureCube<float> gLocalLightShadowCM6 : register(t35);
Texture2D<float> gLocalLightShadowSpot6 : register(t36);
TextureCube<float> gLocalLightShadowCM7 : register(t37);
Texture2D<float> gLocalLightShadowSpot7 : register(t38);


// 3Dmigoto declarations
#define cmp -


void main(
  linear sample float4 v0 : TEXCOORD0,
  linear sample float4 v1 : TEXCOORD1,
  linear sample float4 v2 : TEXCOORD2,
  float4 v3 : TEXCOORD3,
  linear sample float4 v4 : TEXCOORD6,
  linear sample float4 v5 : TEXCOORD8,
  float4 v6 : SV_Position0,
  float4 v7 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyz = gViewInverse._m30_m31_m32 + -v2.xyz;
  r0.w = dot(v1.xyz, r0.xyz);
  r1.x = cmp(0 < r0.w);
  r0.w = cmp(r0.w < 0);
  r0.w = (int)r0.w + (int)-r1.x;
  r0.w = (int)r0.w;
  r1.xyzw = v1.xyzw * r0.wwww;
  r0.w = cmp(r0.w < 0);
  r2.x = min(0.200000003, dirtLevelMod.x);
  r0.w = r0.w ? r2.x : dirtLevelMod.x;
  r2.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v0.xy).xyzw;
  r3.x = dot(r1.xyz, r1.xyz);
  r3.x = rsqrt(r3.x);
  r3.xyz = r3.xxx * r1.xyz;
  r4.xyzw = SpecSampler.Sample(SpecSampler_s, v0.xy).xyzw;
  r4.xy = r4.xy * r4.xy;
  r3.w = dot(r4.xyz, specMapIntMask.xyz);
  r4.x = cmp(0 < vehglassCrackTextureParams[0].x);
  if (r4.x != 0) {
    r4.xy = vehglassCrackTextureParams[0].yy * v0.zw;
    r5.xyz = ddx(v2.xyz);
    r6.xyz = ddy(v2.xyz);
    r7.xy = ddx(r4.xy);
    r7.zw = ddy(r4.xy);
    r8.xyz = r7.zzz * r6.xyz;
    r8.xyz = r7.xxx * r5.xyz + r8.xyz;
    r6.xyz = r7.www * r6.xyz;
    r5.xyz = r7.yyy * r5.xyz + r6.xyz;
    r4.z = dot(r8.xyz, r8.xyz);
    r4.z = sqrt(r4.z);
    r4.z = max(9.99999997e-07, r4.z);
    r6.xyz = r8.xyz / r4.zzz;
    r4.z = dot(r5.xyz, r5.xyz);
    r4.z = sqrt(r4.z);
    r4.z = max(9.99999997e-07, r4.z);
    r5.xyz = r5.xyz / r4.zzz;
    r7.xyzw = vehglassCrackTextureSampler.Sample(vehglassCrackTextureSampler_s, r4.xy).xyzw;
    r4.xy = vehglassCrackTextureParams[0].xz * r7.ww;
    r8.xyzw = float4(1,1,1,1) + -r2.xyzw;
    r2.xyzw = r4.xxxx * r8.xyzw + r2.xyzw;
    r4.x = vehglassCrackTextureParams[1].w * r7.w;
    r8.xyz = vehglassCrackTextureParams[1].xyz + -r2.xyz;
    r2.xyz = r4.xxx * r8.xyz + r2.xyz;
    r4.xz = r7.xy * float2(2,2) + float2(-1,-1);
    r5.w = dot(r4.xz, r4.xz);
    r5.w = 1 + -r5.w;
    r5.w = sqrt(abs(r5.w));
    r6.w = max(0.00100000005, vehglassCrackTextureParams[0].w);
    r4.xz = r6.ww * r4.xz;
    r5.xyz = r4.zzz * r5.xyz;
    r5.xyz = r4.xxx * r6.xyz + r5.xyz;
    r1.xyz = r5.www * r1.xyz + r5.xyz;
    r4.x = dot(r1.xyz, r1.xyz);
    r4.x = rsqrt(r4.x);
    r1.xyz = r4.xxx * r1.xyz;
    r1.xyz = r1.xyz * r4.yyy + r3.xyz;
    r4.x = dot(r1.xyz, r1.xyz);
    r4.x = rsqrt(r4.x);
    r3.xyz = r4.xxx * r1.xyz;
    r1.x = 1 + -r7.w;
  } else {
    r1.x = 1;
  }
  r1.x = v4.w * r1.x;
  r4.xyz = float3(-1,-1,-1) + matDiffuseColorTint.xyz;
  r1.xyz = r1.xxx * r4.xyz + float3(1,1,1);
  r1.xyz = r2.xyz * r1.xyz;
  r2.x = saturate(matDiffuseColorTint.w * v4.w + r2.w);
  r1.xyz = v4.xxx * r1.xyz;
  r2.yz = globalScalars.zy * v4.xx;
  r2.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r2.z = r2.z * r2.w;
  r2.w = v4.x * r3.w;
  r1.w = r2.w * r1.w;
  r4.xy = float2(1,2) + -dirtLevelMod.zz;
  r2.w = v4.z * r4.x;
  r4.yz = v0.zw * r4.yy;
  r5.xyzw = DirtSampler.Sample(DirtSampler_s, r4.yz).xyzw;
  r3.w = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r4.y = r5.z + -r5.x;
  r5.x = r3.w * r4.y + r5.x;
  r4.yz = r5.xy * r0.ww;
  r3.w = v4.z * r4.x + -1;
  r3.w = r4.x * r3.w + 1;
  r4.x = r4.y * r3.w;
  r5.xyw = dirtColor.xyz * dirtLevelMod.yyy + -r1.xyz;
  r1.xyz = r4.xxx * r5.xyw + r1.xyz;
  r0.w = r2.w * r0.w;
  r5.xyz = r5.zzz + -r1.xyz;
  r1.xyz = r0.www * r5.xyz + r1.xyz;
  r0.w = r4.y * r3.w + r2.x;
  r2.x = -r4.z * r3.w + 1;
  r1.w = saturate(r2.x * r1.w);
  r1.xyz = r1.xyz * r1.xyz;
  r2.x = dot(r0.xyz, r0.xyz);
  r2.x = rsqrt(r2.x);
  r4.xyz = r2.xxx * r0.xyz;
  r5.xyz = r0.xyz * r2.xxx + -gDirectionalLight.xyz;
  r2.w = dot(r5.xyz, r5.xyz);
  r2.w = rsqrt(r2.w);
  r5.xyz = r5.xyz * r2.www;
  r2.yz = r2.yz * r2.yz;
  r2.w = r4.w * 510 + -500;
  r2.w = max(0, r2.w);
  r3.w = r4.w * 510 + -r2.w;
  r2.w = 558 * r2.w;
  r2.w = r3.w * 3 + r2.w;
  r6.xyz = -gViewInverse._m30_m31_m32 + v2.xyz;
  r7.xyz = gCSMShaderVars_shared[1].xyz * r6.yyy;
  r7.xyz = r6.xxx * gCSMShaderVars_shared[0].xyz + r7.xyz;
  r7.xyz = r6.zzz * gCSMShaderVars_shared[2].xyz + r7.xyz;
  r8.xyz = r7.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r8.xyz;
  r9.xyz = r7.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r9.xyz;
  r10.xyz = r7.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r10.xyz;
  r7.xyz = r7.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r7.xyz;
  r3.w = -gCSMResolution.z * 1.5 + 1;
  r3.w = 0.5 * r3.w;
  r4.w = max(abs(r10.x), abs(r10.y));
  r4.w = cmp(r4.w < r3.w);
  r4.w = r4.w ? 2 : 3;
  r5.w = max(abs(r9.x), abs(r9.y));
  r5.w = cmp(r5.w < r3.w);
  r4.w = r5.w ? 1 : r4.w;
  r5.w = max(abs(r8.x), abs(r8.y));
  r3.w = cmp(r5.w < r3.w);
  r3.w = r3.w ? 0 : r4.w;
  r7.xyz = x0[r3.w+0].xyz;
  r3.w = (int)r3.w;
  r4.w = 0.5 + r3.w;
  r4.w = 0.25 * r4.w;
  r8.xyzw = cmp(float4(0,1,2,3) == r3.wwww);
  r8.xyzw = r8.xyzw ? float4(1,1,1,1) : 0;
  r3.w = dot(r8.xyzw, gCSMDepthBias.xyzw);
  r5.w = dot(r8.xyzw, gCSMDepthSlopeBias.xyzw);
  r8.x = 0.5 + r7.x;
  r8.y = r7.y * 0.25 + r4.w;
  r4.w = cmp(r3.w != 0.000000);
  r3.w = r7.z + -r3.w;
  r9.xyw = ddx(r8.xyy);
  r9.z = ddx(r3.w);
  r10.xyz = ddy(r8.yxy);
  r10.w = ddy(r3.w);
  r7.xy = r10.yw * r9.yw;
  r11.xy = r9.xz * r10.xz + -r7.xy;
  r6.w = 1 / r11.x;
  r7.x = r10.y * r9.z;
  r11.z = r9.x * r10.w + -r7.x;
  r7.xy = r11.yz * r6.ww;
  r7.xy = max(float2(0,0), r7.xy);
  r7.xy = min(float2(0.5,0.5), r7.xy);
  r3.w = -r5.w * r7.x + r3.w;
  r3.w = -r5.w * r7.y + r3.w;
  r3.w = r4.w ? r3.w : r7.z;
  r3.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r3.w).x;
  r4.w = dot(r3.xyz, -gDirectionalLight.xyz);
  r5.w = saturate(r4.w);
  r5.w = r5.w + -abs(r4.w);
  r4.w = r0.w * r5.w + abs(r4.w);
  r7.x = saturate(dot(r4.xyz, r3.xyz));
  r7.y = saturate(dot(r5.xyz, -gDirectionalLight.xyz));
  r7.xy = float2(1,1) + -r7.xy;
  r7.zw = r7.xy * r7.xy;
  r7.zw = r7.zw * r7.zw;
  r7.xy = r7.zw * r7.xy;
  r7.xy = r7.xy * float2(0.959999979,0.959999979) + float2(0.0399999991,0.0399999991);
  r7.zw = float2(2,9.99999994e-09) + r2.ww;
  r5.w = 0.125 * r7.z;
  r6.w = -r1.w * r7.x + 1;
  r5.x = dot(r3.xyz, r5.xyz);
  r5.x = saturate(9.99999994e-09 + r5.x);
  r5.x = log2(r5.x);
  r5.x = r7.w * r5.x;
  r5.x = exp2(r5.x);
  r5.x = r5.x * r7.y;
  r5.x = r5.x * r5.w;
  r5.x = r5.x * r1.w;
  r5.x = r5.x * r4.w;
  r4.w = r6.w * r4.w;
  r5.xyz = r1.xyz * r4.www + r5.xxx;
  r5.xyz = gDirectionalColour.xyz * r5.xyz;
  r4.w = cmp(0 >= gNumForwardLights);
  if (r4.w == 0) {
    r7.x = cmp(gLightColourAndCapsuleExtent[0].w == 0.000000);
    r8.xyz = gLightPositionAndInvDistSqr[0].xyz + -v2.xyz;
    r9.xyz = -gLightPositionAndInvDistSqr[0].xyz + v2.xyz;
    r7.y = dot(r9.xyz, gLightDirectionAndFalloffExponent[0].xyz);
    r7.z = 9.99999975e-05 + gLightColourAndCapsuleExtent[0].w;
    r7.y = saturate(r7.y / r7.z);
    r7.y = gLightColourAndCapsuleExtent[0].w * r7.y;
    r9.xyz = gLightDirectionAndFalloffExponent[0].xyz * r7.yyy + gLightPositionAndInvDistSqr[0].xyz;
    r9.xyz = -v2.xyz + r9.xyz;
    r7.xyz = r7.xxx ? r8.xyz : r9.xyz;
    r8.x = dot(r7.xyz, r7.xyz);
    r7.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r7.xyz;
    r8.y = dot(r7.xyz, r7.xyz);
    r8.y = rsqrt(r8.y);
    r7.xyz = r8.yyy * r7.xyz;
    r8.x = saturate(-r8.x * gLightPositionAndInvDistSqr[0].w + 1);
    r8.y = 1 + -gLightDirectionAndFalloffExponent[0].w;
    r8.y = r8.y * r8.x + gLightDirectionAndFalloffExponent[0].w;
    r8.x = r8.x / r8.y;
    r8.y = dot(r7.xyz, -gLightDirectionAndFalloffExponent[0].xyz);
    r8.y = saturate(r8.y * gLightConeScale[0] + gLightConeOffset[0]);
    r8.z = dot(r7.xyz, r3.xyz);
    r8.w = saturate(r8.z);
    r8.w = r8.w + -abs(r8.z);
    r8.z = r0.w * r8.w + abs(r8.z);
    r8.w = cmp(gLocalLightShadowData[0]._m03 != 0.000000);
    r9.x = cmp(gShadowTexParam.x == 1.000000);
    r8.w = r8.w ? r9.x : 0;
    if (r8.w != 0) {
      r9.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r6.xyz;
      r10.x = dot(r9.xyz, gLocalLightShadowData[0]._m00_m01_m02);
      r10.y = dot(r9.xyz, gLocalLightShadowData[0]._m10_m11_m12);
      r10.z = dot(r9.xyz, gLocalLightShadowData[0]._m20_m21_m22);
      r8.w = cmp(gLocalLightShadowData[0]._m03 != 3.000000);
      if (r8.w != 0) {
        r11.xyz = -r10.xyz;
        r8.w = dot(r11.xyz, r11.xyz);
        r8.w = sqrt(r8.w);
        r8.w = gLocalLightShadowData[0]._m23 * r8.w;
        r8.w = gLocalLightShadowCM0.SampleCmpLevelZero(gShadowZSamplerCache_s, r11.xyz, r8.w).x;
      } else {
        r10.xy = r10.xy / -r10.zz;
        r10.xy = r10.xy * float2(0.5,-0.5) + float2(0.5,0.5);
        r9.x = dot(r9.xyz, r9.xyz);
        r9.x = sqrt(r9.x);
        r9.x = gLocalLightShadowData[0]._m23 * r9.x;
        r8.w = gLocalLightShadowSpot0.SampleCmpLevelZero(gShadowZSamplerCache_s, r10.xy, r9.x).x;
      }
    } else {
      r8.w = 1;
    }
    r9.x = r8.w * r8.z;
    r9.x = r9.x * r8.y;
    r9.x = r9.x * r8.x;
    r9.xyz = gLightColourAndCapsuleExtent[0].xyz * r9.xxx;
    r9.xyz = r9.xyz * r1.xyz;
    r7.xyz = r0.xyz * r2.xxx + r7.xyz;
    r9.w = dot(r7.xyz, r7.xyz);
    r9.w = rsqrt(r9.w);
    r7.xyz = r9.www * r7.xyz;
    r9.w = saturate(dot(r7.xyz, r4.xyz));
    r9.w = 1 + -r9.w;
    r10.x = r9.w * r9.w;
    r10.x = r10.x * r10.x;
    r9.w = r10.x * r9.w;
    r9.w = r9.w * 0.959999979 + 0.0399999991;
    r7.x = saturate(dot(r7.xyz, r3.xyz));
    r7.x = log2(r7.x);
    r7.x = r7.w * r7.x;
    r7.x = exp2(r7.x);
    r7.x = r9.w * r7.x;
    r7.x = r8.w * r7.x;
    r7.y = r8.z * r8.y;
    r7.x = r7.x * r7.y;
    r7.x = r7.x * r8.x;
    r7.x = r7.x * r5.w;
    r7.xyz = gLightColourAndCapsuleExtent[0].xyz * r7.xxx;
  } else {
    r9.xyz = float3(0,0,0);
    r7.xyz = float3(0,0,0);
  }
  r8.x = cmp(0 < gNumForwardLights);
  if (r8.x != 0) {
    r8.x = cmp(1 >= gNumForwardLights);
    r4.w = (int)r4.w | (int)r8.x;
    r8.x = cmp(1 < gNumForwardLights);
    if (r8.x != 0) {
      r8.x = cmp(gLightColourAndCapsuleExtent[1].w == 0.000000);
      r8.yzw = gLightPositionAndInvDistSqr[1].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[1].xyz + v2.xyz;
      r9.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[1].xyz);
      r10.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[1].w;
      r9.w = saturate(r9.w / r10.x);
      r9.w = gLightColourAndCapsuleExtent[1].w * r9.w;
      r10.xyz = gLightDirectionAndFalloffExponent[1].xyz * r9.www + gLightPositionAndInvDistSqr[1].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r8.xyz = r8.xxx ? r8.yzw : r10.xyz;
      r8.w = dot(r8.xyz, r8.xyz);
      r8.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r8.xyz;
      r9.w = dot(r8.xyz, r8.xyz);
      r9.w = rsqrt(r9.w);
      r8.xyz = r9.www * r8.xyz;
      r8.w = saturate(-r8.w * gLightPositionAndInvDistSqr[1].w + 1);
      r9.w = 1 + -gLightDirectionAndFalloffExponent[1].w;
      r9.w = r9.w * r8.w + gLightDirectionAndFalloffExponent[1].w;
      r8.w = r8.w / r9.w;
      r9.w = dot(r8.xyz, -gLightDirectionAndFalloffExponent[1].xyz);
      r9.w = saturate(r9.w * gLightConeScale[1] + gLightConeOffset[1]);
      r10.x = dot(r8.xyz, r3.xyz);
      r10.y = saturate(r10.x);
      r10.y = r10.y + -abs(r10.x);
      r10.x = r0.w * r10.y + abs(r10.x);
      r10.y = cmp(gLocalLightShadowData[1]._m03 != 0.000000);
      r10.z = cmp(gShadowTexParam.x == 1.000000);
      r10.y = r10.z ? r10.y : 0;
      if (r10.y != 0) {
        r10.yzw = gLocalLightShadowData[1]._m30_m31_m32 + r6.xyz;
        r11.x = dot(r10.yzw, gLocalLightShadowData[1]._m00_m01_m02);
        r11.y = dot(r10.yzw, gLocalLightShadowData[1]._m10_m11_m12);
        r11.z = dot(r10.yzw, gLocalLightShadowData[1]._m20_m21_m22);
        r11.w = cmp(gLocalLightShadowData[1]._m03 != 3.000000);
        if (r11.w != 0) {
          r12.xyz = -r11.xyz;
          r11.w = dot(r12.xyz, r12.xyz);
          r11.w = sqrt(r11.w);
          r11.w = gLocalLightShadowData[1]._m23 * r11.w;
          r11.w = gLocalLightShadowCM1.SampleCmpLevelZero(gShadowZSamplerCache_s, r12.xyz, r11.w).x;
        } else {
          r11.xy = r11.xy / -r11.zz;
          r11.xy = r11.xy * float2(0.5,-0.5) + float2(0.5,0.5);
          r10.y = dot(r10.yzw, r10.yzw);
          r10.y = sqrt(r10.y);
          r10.y = gLocalLightShadowData[1]._m23 * r10.y;
          r11.w = gLocalLightShadowSpot1.SampleCmpLevelZero(gShadowZSamplerCache_s, r11.xy, r10.y).x;
        }
      } else {
        r11.w = 1;
      }
      r10.y = r11.w * r10.x;
      r10.y = r10.y * r9.w;
      r10.y = r10.y * r8.w;
      r10.yzw = gLightColourAndCapsuleExtent[1].xyz * r10.yyy;
      r9.xyz = r10.yzw * r1.xyz + r9.xyz;
      r8.xyz = r0.xyz * r2.xxx + r8.xyz;
      r10.y = dot(r8.xyz, r8.xyz);
      r10.y = rsqrt(r10.y);
      r8.xyz = r10.yyy * r8.xyz;
      r10.y = saturate(dot(r8.xyz, r4.xyz));
      r10.y = 1 + -r10.y;
      r10.z = r10.y * r10.y;
      r10.z = r10.z * r10.z;
      r10.y = r10.y * r10.z;
      r10.y = r10.y * 0.959999979 + 0.0399999991;
      r8.x = saturate(dot(r8.xyz, r3.xyz));
      r8.x = log2(r8.x);
      r8.x = r8.x * r7.w;
      r8.x = exp2(r8.x);
      r8.x = r10.y * r8.x;
      r8.x = r11.w * r8.x;
      r8.y = r10.x * r9.w;
      r8.x = r8.x * r8.y;
      r8.x = r8.x * r8.w;
      r8.x = r8.x * r5.w;
      r7.xyz = r8.xxx * gLightColourAndCapsuleExtent[1].xyz + r7.xyz;
    }
  } else {
    r4.w = -1;
  }
  if (r4.w == 0) {
    r8.x = cmp(2 >= gNumForwardLights);
    r4.w = (int)r4.w | (int)r8.x;
    if (r4.w == 0) {
      r8.x = cmp(gLightColourAndCapsuleExtent[2].w == 0.000000);
      r8.yzw = gLightPositionAndInvDistSqr[2].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[2].xyz + v2.xyz;
      r9.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[2].xyz);
      r10.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[2].w;
      r9.w = saturate(r9.w / r10.x);
      r9.w = gLightColourAndCapsuleExtent[2].w * r9.w;
      r10.xyz = gLightDirectionAndFalloffExponent[2].xyz * r9.www + gLightPositionAndInvDistSqr[2].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r8.xyz = r8.xxx ? r8.yzw : r10.xyz;
      r8.w = dot(r8.xyz, r8.xyz);
      r8.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r8.xyz;
      r9.w = dot(r8.xyz, r8.xyz);
      r9.w = rsqrt(r9.w);
      r8.xyz = r9.www * r8.xyz;
      r8.w = saturate(-r8.w * gLightPositionAndInvDistSqr[2].w + 1);
      r9.w = 1 + -gLightDirectionAndFalloffExponent[2].w;
      r9.w = r9.w * r8.w + gLightDirectionAndFalloffExponent[2].w;
      r8.w = r8.w / r9.w;
      r9.w = dot(r8.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
      r9.w = saturate(r9.w * gLightConeScale[2] + gLightConeOffset[2]);
      r10.x = dot(r8.xyz, r3.xyz);
      r10.y = saturate(r10.x);
      r10.y = r10.y + -abs(r10.x);
      r10.x = r0.w * r10.y + abs(r10.x);
      r10.y = cmp(gLocalLightShadowData[2]._m03 != 0.000000);
      r10.z = cmp(gShadowTexParam.x == 1.000000);
      r10.y = r10.z ? r10.y : 0;
      if (r10.y != 0) {
        r10.yzw = gLocalLightShadowData[2]._m30_m31_m32 + r6.xyz;
        r11.x = dot(r10.yzw, gLocalLightShadowData[2]._m00_m01_m02);
        r11.y = dot(r10.yzw, gLocalLightShadowData[2]._m10_m11_m12);
        r11.z = dot(r10.yzw, gLocalLightShadowData[2]._m20_m21_m22);
        r11.w = cmp(gLocalLightShadowData[2]._m03 != 3.000000);
        if (r11.w != 0) {
          r12.xyz = -r11.xyz;
          r11.w = dot(r12.xyz, r12.xyz);
          r11.w = sqrt(r11.w);
          r11.w = gLocalLightShadowData[2]._m23 * r11.w;
          r11.w = gLocalLightShadowCM2.SampleCmpLevelZero(gShadowZSamplerCache_s, r12.xyz, r11.w).x;
        } else {
          r11.xy = r11.xy / -r11.zz;
          r11.xy = r11.xy * float2(0.5,-0.5) + float2(0.5,0.5);
          r10.y = dot(r10.yzw, r10.yzw);
          r10.y = sqrt(r10.y);
          r10.y = gLocalLightShadowData[2]._m23 * r10.y;
          r11.w = gLocalLightShadowSpot2.SampleCmpLevelZero(gShadowZSamplerCache_s, r11.xy, r10.y).x;
        }
      } else {
        r11.w = 1;
      }
      r10.y = r11.w * r10.x;
      r10.y = r10.y * r9.w;
      r10.y = r10.y * r8.w;
      r10.yzw = gLightColourAndCapsuleExtent[2].xyz * r10.yyy;
      r9.xyz = r10.yzw * r1.xyz + r9.xyz;
      r8.xyz = r0.xyz * r2.xxx + r8.xyz;
      r10.y = dot(r8.xyz, r8.xyz);
      r10.y = rsqrt(r10.y);
      r8.xyz = r10.yyy * r8.xyz;
      r10.y = saturate(dot(r8.xyz, r4.xyz));
      r10.y = 1 + -r10.y;
      r10.z = r10.y * r10.y;
      r10.z = r10.z * r10.z;
      r10.y = r10.y * r10.z;
      r10.y = r10.y * 0.959999979 + 0.0399999991;
      r8.x = saturate(dot(r8.xyz, r3.xyz));
      r8.x = log2(r8.x);
      r8.x = r8.x * r7.w;
      r8.x = exp2(r8.x);
      r8.x = r10.y * r8.x;
      r8.x = r11.w * r8.x;
      r8.y = r10.x * r9.w;
      r8.x = r8.x * r8.y;
      r8.x = r8.x * r8.w;
      r8.x = r8.x * r5.w;
      r7.xyz = r8.xxx * gLightColourAndCapsuleExtent[2].xyz + r7.xyz;
    }
  } else {
    r4.w = -1;
  }
  if (r4.w == 0) {
    r8.x = cmp(3 >= gNumForwardLights);
    r4.w = (int)r4.w | (int)r8.x;
    if (r4.w == 0) {
      r8.x = cmp(gLightColourAndCapsuleExtent[3].w == 0.000000);
      r8.yzw = gLightPositionAndInvDistSqr[3].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[3].xyz + v2.xyz;
      r9.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[3].xyz);
      r10.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[3].w;
      r9.w = saturate(r9.w / r10.x);
      r9.w = gLightColourAndCapsuleExtent[3].w * r9.w;
      r10.xyz = gLightDirectionAndFalloffExponent[3].xyz * r9.www + gLightPositionAndInvDistSqr[3].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r8.xyz = r8.xxx ? r8.yzw : r10.xyz;
      r8.w = dot(r8.xyz, r8.xyz);
      r8.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r8.xyz;
      r9.w = dot(r8.xyz, r8.xyz);
      r9.w = rsqrt(r9.w);
      r8.xyz = r9.www * r8.xyz;
      r8.w = saturate(-r8.w * gLightPositionAndInvDistSqr[3].w + 1);
      r9.w = 1 + -gLightDirectionAndFalloffExponent[3].w;
      r9.w = r9.w * r8.w + gLightDirectionAndFalloffExponent[3].w;
      r8.w = r8.w / r9.w;
      r9.w = dot(r8.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
      r9.w = saturate(r9.w * gLightConeScale[3] + gLightConeOffset[3]);
      r10.x = dot(r8.xyz, r3.xyz);
      r10.y = saturate(r10.x);
      r10.y = r10.y + -abs(r10.x);
      r10.x = r0.w * r10.y + abs(r10.x);
      r10.y = cmp(gLocalLightShadowData[3]._m03 != 0.000000);
      r10.z = cmp(gShadowTexParam.x == 1.000000);
      r10.y = r10.z ? r10.y : 0;
      if (r10.y != 0) {
        r10.yzw = gLocalLightShadowData[3]._m30_m31_m32 + r6.xyz;
        r11.x = dot(r10.yzw, gLocalLightShadowData[3]._m00_m01_m02);
        r11.y = dot(r10.yzw, gLocalLightShadowData[3]._m10_m11_m12);
        r11.z = dot(r10.yzw, gLocalLightShadowData[3]._m20_m21_m22);
        r11.w = cmp(gLocalLightShadowData[3]._m03 != 3.000000);
        if (r11.w != 0) {
          r12.xyz = -r11.xyz;
          r11.w = dot(r12.xyz, r12.xyz);
          r11.w = sqrt(r11.w);
          r11.w = gLocalLightShadowData[3]._m23 * r11.w;
          r11.w = gLocalLightShadowCM3.SampleCmpLevelZero(gShadowZSamplerCache_s, r12.xyz, r11.w).x;
        } else {
          r11.xy = r11.xy / -r11.zz;
          r11.xy = r11.xy * float2(0.5,-0.5) + float2(0.5,0.5);
          r10.y = dot(r10.yzw, r10.yzw);
          r10.y = sqrt(r10.y);
          r10.y = gLocalLightShadowData[3]._m23 * r10.y;
          r11.w = gLocalLightShadowSpot3.SampleCmpLevelZero(gShadowZSamplerCache_s, r11.xy, r10.y).x;
        }
      } else {
        r11.w = 1;
      }
      r10.y = r11.w * r10.x;
      r10.y = r10.y * r9.w;
      r10.y = r10.y * r8.w;
      r10.yzw = gLightColourAndCapsuleExtent[3].xyz * r10.yyy;
      r9.xyz = r10.yzw * r1.xyz + r9.xyz;
      r8.xyz = r0.xyz * r2.xxx + r8.xyz;
      r10.y = dot(r8.xyz, r8.xyz);
      r10.y = rsqrt(r10.y);
      r8.xyz = r10.yyy * r8.xyz;
      r10.y = saturate(dot(r8.xyz, r4.xyz));
      r10.y = 1 + -r10.y;
      r10.z = r10.y * r10.y;
      r10.z = r10.z * r10.z;
      r10.y = r10.y * r10.z;
      r10.y = r10.y * 0.959999979 + 0.0399999991;
      r8.x = saturate(dot(r8.xyz, r3.xyz));
      r8.x = log2(r8.x);
      r8.x = r8.x * r7.w;
      r8.x = exp2(r8.x);
      r8.x = r10.y * r8.x;
      r8.x = r11.w * r8.x;
      r8.y = r10.x * r9.w;
      r8.x = r8.x * r8.y;
      r8.x = r8.x * r8.w;
      r8.x = r8.x * r5.w;
      r7.xyz = r8.xxx * gLightColourAndCapsuleExtent[3].xyz + r7.xyz;
    }
  } else {
    r4.w = -1;
  }
  if (r4.w == 0) {
    r8.x = cmp(4 >= gNumForwardLights);
    r4.w = (int)r4.w | (int)r8.x;
    if (r4.w == 0) {
      r8.x = cmp(gLightColourAndCapsuleExtent[4].w == 0.000000);
      r8.yzw = gLightPositionAndInvDistSqr[4].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[4].xyz + v2.xyz;
      r9.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[4].xyz);
      r10.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[4].w;
      r9.w = saturate(r9.w / r10.x);
      r9.w = gLightColourAndCapsuleExtent[4].w * r9.w;
      r10.xyz = gLightDirectionAndFalloffExponent[4].xyz * r9.www + gLightPositionAndInvDistSqr[4].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r8.xyz = r8.xxx ? r8.yzw : r10.xyz;
      r8.w = dot(r8.xyz, r8.xyz);
      r8.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r8.xyz;
      r9.w = dot(r8.xyz, r8.xyz);
      r9.w = rsqrt(r9.w);
      r8.xyz = r9.www * r8.xyz;
      r8.w = saturate(-r8.w * gLightPositionAndInvDistSqr[4].w + 1);
      r9.w = 1 + -gLightDirectionAndFalloffExponent[4].w;
      r9.w = r9.w * r8.w + gLightDirectionAndFalloffExponent[4].w;
      r8.w = r8.w / r9.w;
      r9.w = dot(r8.xyz, -gLightDirectionAndFalloffExponent[4].xyz);
      r9.w = saturate(r9.w * gLightConeScale[4] + gLightConeOffset[4]);
      r10.x = dot(r8.xyz, r3.xyz);
      r10.y = saturate(r10.x);
      r10.y = r10.y + -abs(r10.x);
      r10.x = r0.w * r10.y + abs(r10.x);
      r10.y = cmp(gLocalLightShadowData[4]._m03 != 0.000000);
      r10.z = cmp(gShadowTexParam.x == 1.000000);
      r10.y = r10.z ? r10.y : 0;
      if (r10.y != 0) {
        r10.yzw = gLocalLightShadowData[4]._m30_m31_m32 + r6.xyz;
        r11.x = dot(r10.yzw, gLocalLightShadowData[4]._m00_m01_m02);
        r11.y = dot(r10.yzw, gLocalLightShadowData[4]._m10_m11_m12);
        r11.z = dot(r10.yzw, gLocalLightShadowData[4]._m20_m21_m22);
        r11.w = cmp(gLocalLightShadowData[4]._m03 != 3.000000);
        if (r11.w != 0) {
          r12.xyz = -r11.xyz;
          r11.w = dot(r12.xyz, r12.xyz);
          r11.w = sqrt(r11.w);
          r11.w = gLocalLightShadowData[4]._m23 * r11.w;
          r11.w = gLocalLightShadowCM4.SampleCmpLevelZero(gShadowZSamplerCache_s, r12.xyz, r11.w).x;
        } else {
          r11.xy = r11.xy / -r11.zz;
          r11.xy = r11.xy * float2(0.5,-0.5) + float2(0.5,0.5);
          r10.y = dot(r10.yzw, r10.yzw);
          r10.y = sqrt(r10.y);
          r10.y = gLocalLightShadowData[4]._m23 * r10.y;
          r11.w = gLocalLightShadowSpot4.SampleCmpLevelZero(gShadowZSamplerCache_s, r11.xy, r10.y).x;
        }
      } else {
        r11.w = 1;
      }
      r10.y = r11.w * r10.x;
      r10.y = r10.y * r9.w;
      r10.y = r10.y * r8.w;
      r10.yzw = gLightColourAndCapsuleExtent[4].xyz * r10.yyy;
      r9.xyz = r10.yzw * r1.xyz + r9.xyz;
      r8.xyz = r0.xyz * r2.xxx + r8.xyz;
      r10.y = dot(r8.xyz, r8.xyz);
      r10.y = rsqrt(r10.y);
      r8.xyz = r10.yyy * r8.xyz;
      r10.y = saturate(dot(r8.xyz, r4.xyz));
      r10.y = 1 + -r10.y;
      r10.z = r10.y * r10.y;
      r10.z = r10.z * r10.z;
      r10.y = r10.y * r10.z;
      r10.y = r10.y * 0.959999979 + 0.0399999991;
      r8.x = saturate(dot(r8.xyz, r3.xyz));
      r8.x = log2(r8.x);
      r8.x = r8.x * r7.w;
      r8.x = exp2(r8.x);
      r8.x = r10.y * r8.x;
      r8.x = r11.w * r8.x;
      r8.y = r10.x * r9.w;
      r8.x = r8.x * r8.y;
      r8.x = r8.x * r8.w;
      r8.x = r8.x * r5.w;
      r7.xyz = r8.xxx * gLightColourAndCapsuleExtent[4].xyz + r7.xyz;
    }
  } else {
    r4.w = -1;
  }
  if (r4.w == 0) {
    r8.x = cmp(5 >= gNumForwardLights);
    r4.w = (int)r4.w | (int)r8.x;
    if (r4.w == 0) {
      r8.x = cmp(gLightColourAndCapsuleExtent[5].w == 0.000000);
      r8.yzw = gLightPositionAndInvDistSqr[5].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[5].xyz + v2.xyz;
      r9.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[5].xyz);
      r10.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[5].w;
      r9.w = saturate(r9.w / r10.x);
      r9.w = gLightColourAndCapsuleExtent[5].w * r9.w;
      r10.xyz = gLightDirectionAndFalloffExponent[5].xyz * r9.www + gLightPositionAndInvDistSqr[5].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r8.xyz = r8.xxx ? r8.yzw : r10.xyz;
      r8.w = dot(r8.xyz, r8.xyz);
      r8.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r8.xyz;
      r9.w = dot(r8.xyz, r8.xyz);
      r9.w = rsqrt(r9.w);
      r8.xyz = r9.www * r8.xyz;
      r8.w = saturate(-r8.w * gLightPositionAndInvDistSqr[5].w + 1);
      r9.w = 1 + -gLightDirectionAndFalloffExponent[5].w;
      r9.w = r9.w * r8.w + gLightDirectionAndFalloffExponent[5].w;
      r8.w = r8.w / r9.w;
      r9.w = dot(r8.xyz, -gLightDirectionAndFalloffExponent[5].xyz);
      r9.w = saturate(r9.w * gLightConeScale[5] + gLightConeOffset[5]);
      r10.x = dot(r8.xyz, r3.xyz);
      r10.y = saturate(r10.x);
      r10.y = r10.y + -abs(r10.x);
      r10.x = r0.w * r10.y + abs(r10.x);
      r10.y = cmp(gLocalLightShadowData[5]._m03 != 0.000000);
      r10.z = cmp(gShadowTexParam.x == 1.000000);
      r10.y = r10.z ? r10.y : 0;
      if (r10.y != 0) {
        r10.yzw = gLocalLightShadowData[5]._m30_m31_m32 + r6.xyz;
        r11.x = dot(r10.yzw, gLocalLightShadowData[5]._m00_m01_m02);
        r11.y = dot(r10.yzw, gLocalLightShadowData[5]._m10_m11_m12);
        r11.z = dot(r10.yzw, gLocalLightShadowData[5]._m20_m21_m22);
        r11.w = cmp(gLocalLightShadowData[5]._m03 != 3.000000);
        if (r11.w != 0) {
          r12.xyz = -r11.xyz;
          r11.w = dot(r12.xyz, r12.xyz);
          r11.w = sqrt(r11.w);
          r11.w = gLocalLightShadowData[5]._m23 * r11.w;
          r11.w = gLocalLightShadowCM5.SampleCmpLevelZero(gShadowZSamplerCache_s, r12.xyz, r11.w).x;
        } else {
          r11.xy = r11.xy / -r11.zz;
          r11.xy = r11.xy * float2(0.5,-0.5) + float2(0.5,0.5);
          r10.y = dot(r10.yzw, r10.yzw);
          r10.y = sqrt(r10.y);
          r10.y = gLocalLightShadowData[5]._m23 * r10.y;
          r11.w = gLocalLightShadowSpot5.SampleCmpLevelZero(gShadowZSamplerCache_s, r11.xy, r10.y).x;
        }
      } else {
        r11.w = 1;
      }
      r10.y = r11.w * r10.x;
      r10.y = r10.y * r9.w;
      r10.y = r10.y * r8.w;
      r10.yzw = gLightColourAndCapsuleExtent[5].xyz * r10.yyy;
      r9.xyz = r10.yzw * r1.xyz + r9.xyz;
      r8.xyz = r0.xyz * r2.xxx + r8.xyz;
      r10.y = dot(r8.xyz, r8.xyz);
      r10.y = rsqrt(r10.y);
      r8.xyz = r10.yyy * r8.xyz;
      r10.y = saturate(dot(r8.xyz, r4.xyz));
      r10.y = 1 + -r10.y;
      r10.z = r10.y * r10.y;
      r10.z = r10.z * r10.z;
      r10.y = r10.y * r10.z;
      r10.y = r10.y * 0.959999979 + 0.0399999991;
      r8.x = saturate(dot(r8.xyz, r3.xyz));
      r8.x = log2(r8.x);
      r8.x = r8.x * r7.w;
      r8.x = exp2(r8.x);
      r8.x = r10.y * r8.x;
      r8.x = r11.w * r8.x;
      r8.y = r10.x * r9.w;
      r8.x = r8.x * r8.y;
      r8.x = r8.x * r8.w;
      r8.x = r8.x * r5.w;
      r7.xyz = r8.xxx * gLightColourAndCapsuleExtent[5].xyz + r7.xyz;
    }
  } else {
    r4.w = -1;
  }
  if (r4.w == 0) {
    r8.x = cmp(6 >= gNumForwardLights);
    r4.w = (int)r4.w | (int)r8.x;
    if (r4.w == 0) {
      r8.x = cmp(gLightColourAndCapsuleExtent[6].w == 0.000000);
      r8.yzw = gLightPositionAndInvDistSqr[6].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[6].xyz + v2.xyz;
      r9.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[6].xyz);
      r10.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[6].w;
      r9.w = saturate(r9.w / r10.x);
      r9.w = gLightColourAndCapsuleExtent[6].w * r9.w;
      r10.xyz = gLightDirectionAndFalloffExponent[6].xyz * r9.www + gLightPositionAndInvDistSqr[6].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r8.xyz = r8.xxx ? r8.yzw : r10.xyz;
      r8.w = dot(r8.xyz, r8.xyz);
      r8.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r8.xyz;
      r9.w = dot(r8.xyz, r8.xyz);
      r9.w = rsqrt(r9.w);
      r8.xyz = r9.www * r8.xyz;
      r8.w = saturate(-r8.w * gLightPositionAndInvDistSqr[6].w + 1);
      r9.w = 1 + -gLightDirectionAndFalloffExponent[6].w;
      r9.w = r9.w * r8.w + gLightDirectionAndFalloffExponent[6].w;
      r8.w = r8.w / r9.w;
      r9.w = dot(r8.xyz, -gLightDirectionAndFalloffExponent[6].xyz);
      r9.w = saturate(r9.w * gLightConeScale[6] + gLightConeOffset[6]);
      r10.x = dot(r8.xyz, r3.xyz);
      r10.y = saturate(r10.x);
      r10.y = r10.y + -abs(r10.x);
      r10.x = r0.w * r10.y + abs(r10.x);
      r10.y = cmp(gLocalLightShadowData[6]._m03 != 0.000000);
      r10.z = cmp(gShadowTexParam.x == 1.000000);
      r10.y = r10.z ? r10.y : 0;
      if (r10.y != 0) {
        r10.yzw = gLocalLightShadowData[6]._m30_m31_m32 + r6.xyz;
        r11.x = dot(r10.yzw, gLocalLightShadowData[6]._m00_m01_m02);
        r11.y = dot(r10.yzw, gLocalLightShadowData[6]._m10_m11_m12);
        r11.z = dot(r10.yzw, gLocalLightShadowData[6]._m20_m21_m22);
        r11.w = cmp(gLocalLightShadowData[6]._m03 != 3.000000);
        if (r11.w != 0) {
          r12.xyz = -r11.xyz;
          r11.w = dot(r12.xyz, r12.xyz);
          r11.w = sqrt(r11.w);
          r11.w = gLocalLightShadowData[6]._m23 * r11.w;
          r11.w = gLocalLightShadowCM6.SampleCmpLevelZero(gShadowZSamplerCache_s, r12.xyz, r11.w).x;
        } else {
          r11.xy = r11.xy / -r11.zz;
          r11.xy = r11.xy * float2(0.5,-0.5) + float2(0.5,0.5);
          r10.y = dot(r10.yzw, r10.yzw);
          r10.y = sqrt(r10.y);
          r10.y = gLocalLightShadowData[6]._m23 * r10.y;
          r11.w = gLocalLightShadowSpot6.SampleCmpLevelZero(gShadowZSamplerCache_s, r11.xy, r10.y).x;
        }
      } else {
        r11.w = 1;
      }
      r10.y = r11.w * r10.x;
      r10.y = r10.y * r9.w;
      r10.y = r10.y * r8.w;
      r10.yzw = gLightColourAndCapsuleExtent[6].xyz * r10.yyy;
      r9.xyz = r10.yzw * r1.xyz + r9.xyz;
      r8.xyz = r0.xyz * r2.xxx + r8.xyz;
      r10.y = dot(r8.xyz, r8.xyz);
      r10.y = rsqrt(r10.y);
      r8.xyz = r10.yyy * r8.xyz;
      r10.y = saturate(dot(r8.xyz, r4.xyz));
      r10.y = 1 + -r10.y;
      r10.z = r10.y * r10.y;
      r10.z = r10.z * r10.z;
      r10.y = r10.y * r10.z;
      r10.y = r10.y * 0.959999979 + 0.0399999991;
      r8.x = saturate(dot(r8.xyz, r3.xyz));
      r8.x = log2(r8.x);
      r8.x = r8.x * r7.w;
      r8.x = exp2(r8.x);
      r8.x = r10.y * r8.x;
      r8.x = r11.w * r8.x;
      r8.y = r10.x * r9.w;
      r8.x = r8.x * r8.y;
      r8.x = r8.x * r8.w;
      r8.x = r8.x * r5.w;
      r7.xyz = r8.xxx * gLightColourAndCapsuleExtent[6].xyz + r7.xyz;
    }
  } else {
    r4.w = -1;
  }
  if (r4.w == 0) {
    r8.x = cmp(7 >= gNumForwardLights);
    r4.w = (int)r4.w | (int)r8.x;
    if (r4.w == 0) {
      r4.w = cmp(gLightColourAndCapsuleExtent[7].w == 0.000000);
      r8.xyz = gLightPositionAndInvDistSqr[7].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[7].xyz + v2.xyz;
      r8.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[7].xyz);
      r9.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[7].w;
      r8.w = saturate(r8.w / r9.w);
      r8.w = gLightColourAndCapsuleExtent[7].w * r8.w;
      r10.xyz = gLightDirectionAndFalloffExponent[7].xyz * r8.www + gLightPositionAndInvDistSqr[7].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r8.xyz = r4.www ? r8.xyz : r10.xyz;
      r4.w = dot(r8.xyz, r8.xyz);
      r8.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r8.xyz;
      r8.w = dot(r8.xyz, r8.xyz);
      r8.w = rsqrt(r8.w);
      r8.xyz = r8.xyz * r8.www;
      r4.w = saturate(-r4.w * gLightPositionAndInvDistSqr[7].w + 1);
      r8.w = 1 + -gLightDirectionAndFalloffExponent[7].w;
      r8.w = r8.w * r4.w + gLightDirectionAndFalloffExponent[7].w;
      r4.w = r4.w / r8.w;
      r8.w = dot(r8.xyz, -gLightDirectionAndFalloffExponent[7].xyz);
      r8.w = saturate(r8.w * gLightConeScale[7] + gLightConeOffset[7]);
      r9.w = dot(r8.xyz, r3.xyz);
      r10.x = saturate(r9.w);
      r10.x = r10.x + -abs(r9.w);
      r9.w = r0.w * r10.x + abs(r9.w);
      r10.x = cmp(gLocalLightShadowData[7]._m03 != 0.000000);
      r10.y = cmp(gShadowTexParam.x == 1.000000);
      r10.x = r10.y ? r10.x : 0;
      if (r10.x != 0) {
        r6.xyz = gLocalLightShadowData[7]._m30_m31_m32 + r6.xyz;
        r10.x = dot(r6.xyz, gLocalLightShadowData[7]._m00_m01_m02);
        r10.y = dot(r6.xyz, gLocalLightShadowData[7]._m10_m11_m12);
        r10.z = dot(r6.xyz, gLocalLightShadowData[7]._m20_m21_m22);
        r10.w = cmp(gLocalLightShadowData[7]._m03 != 3.000000);
        if (r10.w != 0) {
          r11.xyz = -r10.xyz;
          r10.w = dot(r11.xyz, r11.xyz);
          r10.w = sqrt(r10.w);
          r10.w = gLocalLightShadowData[7]._m23 * r10.w;
          r10.w = gLocalLightShadowCM7.SampleCmpLevelZero(gShadowZSamplerCache_s, r11.xyz, r10.w).x;
        } else {
          r10.xy = r10.xy / -r10.zz;
          r10.xy = r10.xy * float2(0.5,-0.5) + float2(0.5,0.5);
          r6.x = dot(r6.xyz, r6.xyz);
          r6.x = sqrt(r6.x);
          r6.x = gLocalLightShadowData[7]._m23 * r6.x;
          r10.w = gLocalLightShadowSpot7.SampleCmpLevelZero(gShadowZSamplerCache_s, r10.xy, r6.x).x;
        }
      } else {
        r10.w = 1;
      }
      r6.x = r10.w * r9.w;
      r6.x = r6.x * r8.w;
      r6.x = r6.x * r4.w;
      r6.xyz = gLightColourAndCapsuleExtent[7].xyz * r6.xxx;
      r9.xyz = r6.xyz * r1.xyz + r9.xyz;
      r0.xyz = r0.xyz * r2.xxx + r8.xyz;
      r2.x = dot(r0.xyz, r0.xyz);
      r2.x = rsqrt(r2.x);
      r0.xyz = r2.xxx * r0.xyz;
      r2.x = saturate(dot(r0.xyz, r4.xyz));
      r2.x = 1 + -r2.x;
      r6.x = r2.x * r2.x;
      r6.x = r6.x * r6.x;
      r2.x = r6.x * r2.x;
      r2.x = r2.x * 0.959999979 + 0.0399999991;
      r0.x = saturate(dot(r0.xyz, r3.xyz));
      r0.x = log2(r0.x);
      r0.x = r7.w * r0.x;
      r0.x = exp2(r0.x);
      r0.x = r2.x * r0.x;
      r0.x = r10.w * r0.x;
      r0.y = r9.w * r8.w;
      r0.x = r0.x * r0.y;
      r0.x = r0.x * r4.w;
      r0.x = r0.x * r5.w;
      r7.xyz = r0.xxx * gLightColourAndCapsuleExtent[7].xyz + r7.xyz;
    }
  }
  r0.x = r6.w * r6.w;
  r0.y = r1.w * r1.w;
  r6.xyz = r0.yyy * r7.xyz;
  r0.xyz = r0.xxx * r9.xyz + r6.xyz;
  r0.xyz = r5.xyz * r3.www + r0.xyz;
  r1.w = gLightNaturalAmbient0.w + r3.z;
  r1.w = gLightNaturalAmbient1.w * r1.w;
  r1.w = max(0, r1.w);
  r5.xyz = gLightArtificialExtAmbient0.xyz * r1.www + gLightArtificialExtAmbient1.xyz;
  r2.x = 1 + -globalScalars2.z;
  r6.xyz = gLightArtificialIntAmbient0.xyz * r1.www + gLightArtificialIntAmbient1.xyz;
  r6.xyz = globalScalars2.zzz * r6.xyz;
  r5.xyz = r5.xyz * r2.xxx + r6.xyz;
  r5.xyz = r5.xyz * r2.zzz;
  r6.xyz = gLightNaturalAmbient0.xyz * r1.www + gLightNaturalAmbient1.xyz;
  r7.x = gLightArtificialIntAmbient1.w;
  r7.y = gLightArtificialExtAmbient0.w;
  r7.z = gLightArtificialExtAmbient1.w;
  r1.w = saturate(dot(r7.xyz, r3.xyz));
  r6.xyz = gDirectionalAmbientColour.xyz * r1.www + r6.xyz;
  r5.xyz = r6.xyz * r2.yyy + r5.xyz;
  r5.xyz = r5.xyz * r6.www;
  r0.xyz = r5.xyz * r1.xyz + r0.xyz;
  r1.x = 1 + -r6.w;
  r1.y = dot(-r4.xyz, r3.xyz);
  r1.y = r1.y + r1.y;
  r1.yzw = r3.xyz * -r1.yyy + -r4.xyz;
  r2.xw = saturate(float2(0.000666666718,0.00177619897) * r2.ww);
  r2.x = 1 + -r2.x;
  r3.x = -5 + gReflectionMipCount;
  r3.y = gReflectionMipCount * r2.x;
  r3.y = cmp(r3.y < r3.x);
  r3.z = r2.x * gReflectionMipCount + -5;
  r2.x = r2.x * r2.x;
  r2.x = r2.x * 5 + r3.x;
  r2.x = r3.y ? r3.z : r2.x;
  r3.xyz = float3(-0.25,0.5,0.25) * r1.yzy;
  r1.y = 1 + abs(r1.w);
  r3.xyz = r3.xyz / r1.yyy;
  r3.xyz = float3(0.75,0.5,0.25) + -r3.xyz;
  r1.y = cmp(0 < r1.w);
  r1.yz = r1.yy ? r3.xy : r3.zy;
  r3.xyzw = ReflectionSampler.SampleLevel(ReflectionSampler_s, r1.yz, r2.x).xyzw;
  r1.y = max(r2.y, r2.z);
  r1.yzw = r3.xyz * r1.yyy;
  r2.xyz = r1.yzw * r2.www;
  r2.xyz = float3(0.681690097,0.681690097,0.681690097) * r2.xyz;
  r1.yzw = r1.yzw * float3(0.318309903,0.318309903,0.318309903) + r2.xyz;
  r0.xyz = r1.yzw * r1.xxx + r0.xyz;
  o0.w = saturate(globalScalars.x * r0.w);
  r0.w = cmp(0 < gGlobalFogIntensity);
  if (r0.w != 0) {
    r1.xy = globalScreenSize.zw * v6.xy;
    r1.xyzw = FogRaySampler.Sample(FogRaySampler_s, r1.xy).xyzw;
    r0.w = -1 + r1.x;
    r0.w = saturate(gGlobalFogIntensity * r0.w + 1);
  } else {
    r0.w = 1;
  }
  r0.w = v5.w * r0.w;
  r1.xyz = v5.xyz + -r0.xyz;
  r0.xyz = r0.www * r1.xyz + r0.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  return;
}