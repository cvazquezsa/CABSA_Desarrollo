[Forma]
Clave=CteEnviarALista
Nombre=<T>Sucursales del Cliente<T>
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=298
PosicionInicialArriba=201
PosicionInicialAltura=391
PosicionInicialAncho=684
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cliente
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=364

VentanaEstadoInicial=Normal
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteEnviarA
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Lista
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ElementosPorPagina=200

Filtros=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosSubTitulo=<T>Enviar a<T>
IconosNombre=CteEnviarA:CteEnviarA.ID
FiltroGeneral={<T>CteEnviarA.Cliente = <T> + Si(Info.Cliente en (<T>(TODOS)<T>,nulo), <T>CteEnviarA.Cliente<T>,Comillas(Info.Cliente))}
[Lista.CteEnviarA.Nombre]
Carpeta=Lista
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Detalle.CteEnviarA.Nombre]
Carpeta=Detalle
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=63

[Detalle.CteEnviarA.Direccion]
Carpeta=Detalle
Clave=CteEnviarA.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=63

[Detalle.CteEnviarA.Colonia]
Carpeta=Detalle
Clave=CteEnviarA.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.CteEnviarA.CodigoPostal]
Carpeta=Detalle
Clave=CteEnviarA.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20

[Detalle.CteEnviarA.Poblacion]
Carpeta=Detalle
Clave=CteEnviarA.Poblacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20

[Detalle.CteEnviarA.Estado]
Carpeta=Detalle
Clave=CteEnviarA.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.CteEnviarA.Pais]
Carpeta=Detalle
Clave=CteEnviarA.Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20

[Detalle.CteEnviarA.Zona]
Carpeta=Detalle
Clave=CteEnviarA.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.CteEnviarA.Telefonos]
Carpeta=Detalle
Clave=CteEnviarA.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=63
EspacioPrevio=S

[Detalle.CteEnviarA.Fax]
Carpeta=Detalle
Clave=CteEnviarA.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.CteEnviarA.PedirTono]
Carpeta=Detalle
Clave=CteEnviarA.PedirTono
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20

[Detalle.CteEnviarA.Contacto1]
Carpeta=Detalle
Clave=CteEnviarA.Contacto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.CteEnviarA.Contacto2]
Carpeta=Detalle
Clave=CteEnviarA.Contacto2
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=32

[Detalle.CteEnviarA.eMail1]
Carpeta=Detalle
Clave=CteEnviarA.eMail1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.CteEnviarA.eMail2]
Carpeta=Detalle
Clave=CteEnviarA.eMail2
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=32

[Detalle.CteEnviarA.FormaEnvio]
Carpeta=Detalle
Clave=CteEnviarA.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=S

[Detalle.CteEnviarA.Notas]
Carpeta=Detalle
Clave=CteEnviarA.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=63x3

[Lista.Columnas]
EnviarA=76
Nombre=218
ID=58
Direccion=193
Clave=53
0=66
1=60

2=206
3=104
4=-2
[Detalle.CteEnviarA.ZonaImpuesto]
Carpeta=Detalle
Clave=CteEnviarA.ZonaImpuesto
Editar=S
ValidaNombre=S
3D=S
Tamano=20

[Lista.CteEnviarA.Direccion]
Carpeta=Lista
Clave=CteEnviarA.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=250
ColorFondo=Blanco

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Visible=S
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.CteEnviarA.Clave]
Carpeta=Lista
Clave=CteEnviarA.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

































[Acciones.Seleccionar.Seleccionar/Aceptar]
Nombre=Seleccionar/Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Activo=S
Visible=S





[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Seleccionar/Aceptar
Seleccionar/Aceptar=Expresion
Expresion=(Fin)











[Lista.CteEnviarA.Cliente]
Carpeta=Lista
Clave=CteEnviarA.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco








[Lista.ListaEnCaptura]
(Inicio)=CteEnviarA.Clave
CteEnviarA.Clave=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Direccion
CteEnviarA.Direccion=CteEnviarA.Cliente
CteEnviarA.Cliente=(Fin)

















[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
