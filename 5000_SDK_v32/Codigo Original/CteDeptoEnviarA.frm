[Forma]
Clave=CteDeptoEnviarA
Nombre=Datos CFD
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Cliente, Info.Numero)
ListaAcciones=Aceptar
PosicionInicialIzquierda=273
PosicionInicialArriba=362
PosicionInicialAlturaCliente=273
PosicionInicialAncho=733
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteDeptoEnviarA
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=CteDeptoEnviarA.Cliente=<T>{Info.Cliente}<T> AND<BR>CteDeptoEnviarA.Departamento={Info.Numero}

[Lista.CteDeptoEnviarA.EnviarA]
Carpeta=Lista
Clave=CteDeptoEnviarA.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteEnviarA.Nombre]
Carpeta=Lista
Clave=CteEnviarA.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CteDeptoEnviarA.ProveedorID]
Carpeta=Lista
Clave=CteDeptoEnviarA.ProveedorID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
EnviarA=81
Nombre=192
ProveedorID=102
Empresa=58
Nombre_1=268

[Lista.CteDeptoEnviarA.Empresa]
Carpeta=Lista
Clave=CteDeptoEnviarA.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ListaEnCaptura]
(Inicio)=CteDeptoEnviarA.Empresa
CteDeptoEnviarA.Empresa=Empresa.Nombre
Empresa.Nombre=CteDeptoEnviarA.EnviarA
CteDeptoEnviarA.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=CteDeptoEnviarA.ProveedorID
CteDeptoEnviarA.ProveedorID=(Fin)
