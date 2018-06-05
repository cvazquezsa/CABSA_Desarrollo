[Forma]
Clave=MovProyCfg
Nombre=Movimientos desde el Proyecto
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=296
PosicionInicialArriba=155
PosicionInicialAlturaCliente=379
PosicionInicialAncho=773
PosicionColumna1=50
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionCol1=381

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovProy
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovProy.Nombre
CarpetaVisible=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=MovProy.Orden<TAB>(Acendente)

[Lista.MovProy.Nombre]
Carpeta=Lista
Clave=MovProy.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovProy
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S

[Ficha.MovProy.Nombre]
Carpeta=Ficha
Clave=MovProy.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
Efectos=[Negritas]

[Ficha.MovProy.Tipo]
Carpeta=Ficha
Clave=MovProy.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
Efectos=[Negritas]

[Ficha.MovProy.Modulo]
Carpeta=Ficha
Clave=MovProy.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.Modulo.Nombre]
Carpeta=Ficha
Clave=Modulo.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=39
ColorFondo=Plata

[Ficha.MovProy.SubModulo]
Carpeta=Ficha
Clave=MovProy.SubModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha.SubModulo.Nombre]
Carpeta=Ficha
Clave=SubModulo.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=39
ColorFondo=Plata

[Ficha.MovProy.NivelAcceso]
Carpeta=Ficha
Clave=MovProy.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Nombre=347

0=116
1=266
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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Ficha.MovProy.Mov]
Carpeta=Ficha
Clave=MovProy.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>MovProyOrdenar<T>)




[Ficha.MovProy.Proveedor]
Carpeta=Ficha
Clave=MovProy.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







[Ficha.ListaEnCaptura]
(Inicio)=MovProy.Nombre
MovProy.Nombre=MovProy.Tipo
MovProy.Tipo=MovProy.NivelAcceso
MovProy.NivelAcceso=MovProy.Modulo
MovProy.Modulo=Modulo.Nombre
Modulo.Nombre=MovProy.SubModulo
MovProy.SubModulo=SubModulo.Nombre
SubModulo.Nombre=MovProy.Mov
MovProy.Mov=MovProy.Proveedor
MovProy.Proveedor=(Fin)











[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=Ordenar
Ordenar=(Fin)
