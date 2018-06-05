[Forma]
Clave=HerrWebUsuario
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
CarpetaPrincipal=HerrWebUsuario
ListaCarpetas=HerrWebUsuario
PosicionInicialIzquierda=243
PosicionInicialArriba=193
PosicionInicialAlturaCliente=435
PosicionInicialAncho=1114
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=Generar Usuarios eCommerce
[HerrWebUsuario]
Estilo=Iconos
Clave=HerrWebUsuario
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cte
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Clientes
Filtros=S
BusquedaRapidaControles=S
IconosSubTitulo=<T>Cliente<T>
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosSeleccionMultiple=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Agente
FiltroAplicaEn1=Cte.Categoria
FiltroAplicaEn2=Cte.Familia
FiltroAplicaEn3=Cte.Grupo
FiltroAplicaEn4=Cte.Agente
FiltroTodo=S
FiltroListas=S
FiltroListasRama=CXC
FiltroListasAplicaEn=Cte.Cliente
FiltroArbol=Clientes
FiltroArbolAplica=Cte.Rama
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroTodoFinal=S
IconosNombre=Cte:Cte.Cliente
FiltroGeneral=Cte.Tipo<><T>Estructura<T>
[HerrWebUsuario.Columnas]
0=91
1=250
2=290
3=287
4=155
[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
[Acciones.Expresion]
Nombre=Expresion
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Contacto 1
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=RegistrarSeleccion(<T>HerrWebUsuario<T>) <BR>EjecutarSQL(<T>speCommerceHerrWebUsuario :nEstacion, :tEmpresa, :nSucursal, :nTipo<T>,EstacionTrabajo,Empresa,Sucursal,1)<BR>FormaModal(<T>WebUsuarioTemp<T>)
[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar Contacto 2
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=RegistrarSeleccion(<T>HerrWebUsuario<T>) <BR>EjecutarSQL(<T>speCommerceHerrWebUsuario :nEstacion, :tEmpresa, :nSucursal, :nTipo<T>,EstacionTrabajo,Empresa,Sucursal,2)<BR>FormaModal(<T>WebUsuarioTemp<T>)
[HerrWebUsuario.Cte.Nombre]
Carpeta=HerrWebUsuario
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
[HerrWebUsuario.Cte.Contacto1]
Carpeta=HerrWebUsuario
Clave=Cte.Contacto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
[HerrWebUsuario.Cte.Contacto2]
Carpeta=HerrWebUsuario
Clave=Cte.Contacto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[HerrWebUsuario.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=Cte.Contacto1
Cte.Contacto1=Cte.Contacto2
Cte.Contacto2=(Fin)

[HerrWebUsuario.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQ_AVISO
BLOQ_AVISO=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)






[WebUsuarioTemp.Columnas]
Cliente=85
Nombre=267
Apellido=291
eMail=196
eMail2=269
Contrasena=123
ContrasenaConfirmacion=120
Telefono=147







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=Generar
Generar=(Fin)
