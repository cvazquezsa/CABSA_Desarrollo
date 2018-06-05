[Forma]
Clave=NominaConceptoCuenta
Nombre=Cuentas Contables (Conceptos Nómina)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=294
PosicionInicialArriba=222
PosicionInicialAlturaCliente=553
PosicionInicialAncho=692
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaConcepto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=NominaConcepto.NominaConcepto<TAB>(Acendente)

[Lista.NominaConcepto.NominaConcepto]
Carpeta=Lista
Clave=NominaConcepto.NominaConcepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.NominaConcepto.Concepto]
Carpeta=Lista
Clave=NominaConcepto.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.NominaConcepto.CuentaBase]
Carpeta=Lista
Clave=NominaConcepto.CuentaBase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaConcepto.Cuenta]
Carpeta=Lista
Clave=NominaConcepto.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaConcepto.CuentaGrupo]
Carpeta=Lista
Clave=NominaConcepto.CuentaGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
NominaConcepto=64
Concepto=244
CuentaBase=87
Cuenta=98
CuentaGrupo=68
Cuenta2=98

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.NominaConcepto.Cuenta2]
Carpeta=Lista
Clave=NominaConcepto.Cuenta2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=NominaConcepto.NominaConcepto
NominaConcepto.NominaConcepto=NominaConcepto.Concepto
NominaConcepto.Concepto=NominaConcepto.CuentaBase
NominaConcepto.CuentaBase=NominaConcepto.Cuenta
NominaConcepto.Cuenta=NominaConcepto.Cuenta2
NominaConcepto.Cuenta2=NominaConcepto.CuentaGrupo
NominaConcepto.CuentaGrupo=(Fin)
