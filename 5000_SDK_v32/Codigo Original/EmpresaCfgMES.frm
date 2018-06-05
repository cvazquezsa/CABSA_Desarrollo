
[Forma]
Clave=EmpresaCfgMES
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Configuración MES
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Detalle
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=491
PosicionInicialArriba=117
PosicionInicialAlturaCliente=456
PosicionInicialAncho=479
PosicionCol1=329
ListaAcciones=(Lista)

[Lista.EmpresaCfgMES.Empresa]
Carpeta=Lista
Clave=EmpresaCfgMES.Empresa
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco


[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMES
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Detalle.EmpresaCfgMES.Empresa]
Carpeta=Detalle
Clave=EmpresaCfgMES.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Empresa.Nombre]
Carpeta=Detalle
Clave=Empresa.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Detalle.EmpresaCfgMES.Servidor]
Carpeta=Detalle
Clave=EmpresaCfgMES.Servidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.EmpresaCfgMES.BD]
Carpeta=Detalle
Clave=EmpresaCfgMES.BD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.EmpresaCfgMES.MonedaIntelisis]
Carpeta=Detalle
Clave=EmpresaCfgMES.MonedaIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.EmpresaCfgMES.PaisIntelisis]
Carpeta=Detalle
Clave=EmpresaCfgMES.PaisIntelisis
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





LineaNueva=S

[Lista.Columnas]
Empresa=71



Nombre=371

[Detalle.MonedaMES]
Carpeta=Detalle
Clave=MonedaMES
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PaisMES]
Carpeta=Detalle
Clave=PaisMES
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgMES.Empresa
EmpresaCfgMES.Empresa=Empresa.Nombre
Empresa.Nombre=(Fin)

[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco










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













[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=Eliminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S




















[Detalle.EmpresaCfg.IntelMESInterfase]
Carpeta=Detalle
Clave=EmpresaCfg.IntelMESInterfase
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Detalle.EmpresaCfg.IntelMESInterfaseRuta]
Carpeta=Detalle
Clave=EmpresaCfg.IntelMESInterfaseRuta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=61
ColorFondo=Blanco












[Detalle.EstadoMES]
Carpeta=Detalle
Clave=EstadoMES
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=61
ColorFondo=Blanco

[Detalle.ValorMES]
Carpeta=Detalle
Clave=ValorMES
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco














[Detalle.ModuloMES]
Carpeta=Detalle
Clave=ModuloMES
Editar=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco






[Acciones.SucursalMES]
Nombre=SucursalMES
Boton=103
NombreEnBoton=S
NombreDesplegar=&Sucursales
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SucursalMES
Activo=S
Visible=S












[Detalle.EmpresaCfgMES.RutaSituacionArticulo]
Carpeta=Detalle
Clave=EmpresaCfgMES.RutaSituacionArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=61
ColorFondo=Blanco


















[Detalle.EmpresaCfgMES.TransferenciaManual]
Carpeta=Detalle
Clave=EmpresaCfgMES.TransferenciaManual
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco






[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)




[Detalle.ListaEnCaptura]
(Inicio)=EmpresaCfgMES.Empresa
EmpresaCfgMES.Empresa=Empresa.Nombre
Empresa.Nombre=EmpresaCfgMES.Servidor
EmpresaCfgMES.Servidor=EmpresaCfgMES.BD
EmpresaCfgMES.BD=EmpresaCfgMES.MonedaIntelisis
EmpresaCfgMES.MonedaIntelisis=MonedaMES
MonedaMES=EmpresaCfgMES.PaisIntelisis
EmpresaCfgMES.PaisIntelisis=PaisMES
PaisMES=EmpresaCfgMES.TransferenciaManual
EmpresaCfgMES.TransferenciaManual=EmpresaCfgMES.RutaSituacionArticulo
EmpresaCfgMES.RutaSituacionArticulo=EmpresaCfg.IntelMESInterfase
EmpresaCfg.IntelMESInterfase=EmpresaCfg.IntelMESInterfaseRuta
EmpresaCfg.IntelMESInterfaseRuta=EstadoMES
EstadoMES=ValorMES
ValorMES=ModuloMES
ModuloMES=(Fin)



















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Eliminar
Eliminar=SucursalMES
SucursalMES=(Fin)
