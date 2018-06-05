[Forma]
Clave=TipoEmpaque
Nombre=Tipos de Empaques
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=350
PosicionInicialArriba=292
PosicionInicialAlturaCliente=412
PosicionInicialAncho=580
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoEmpaque
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.TipoEmpaque.TipoEmpaque]
Carpeta=Lista
Clave=TipoEmpaque.TipoEmpaque
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
TipoEmpaque=304
Clave=124
Tipo=122

[Lista.TipoEmpaque.Clave]
Carpeta=Lista
Clave=TipoEmpaque.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TipoEmpaque.Tipo]
Carpeta=Lista
Clave=TipoEmpaque.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=TipoEmpaque.TipoEmpaque
TipoEmpaque.TipoEmpaque=TipoEmpaque.Clave
TipoEmpaque.Clave=TipoEmpaque.Tipo
TipoEmpaque.Tipo=(Fin)
