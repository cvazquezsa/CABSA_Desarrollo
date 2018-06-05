[Forma]
Clave=CfgRegistro
Nombre=Configuración del Registro
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=383
PosicionInicialArriba=343
PosicionInicialAlturaCliente=304
PosicionInicialAncho=514
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgRegistro
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.CfgRegistro.Nombre]
Carpeta=Ficha
Clave=CfgRegistro.Nombre
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
DialogoMensaje=EstaSeguroPrecaucion

[Ficha.CfgRegistro.CfgRegistro]
Carpeta=Ficha
Clave=CfgRegistro.CfgRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CuentasMayor]
Nombre=CuentasMayor
Boton=51
NombreEnBoton=S
NombreDesplegar=Cuentas Mayor
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CfgRegistroCuenta
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Numero, CfgRegistro:CfgRegistro.CfgRegistro)<BR>Asigna(Info.Nombre, CfgRegistro:CfgRegistro.Nombre)

[Ficha.CfgRegistro.FechaCancelaciones]
Carpeta=Ficha
Clave=CfgRegistro.FechaCancelaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=CuentasMayor
CuentasMayor=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CfgRegistro.CfgRegistro
CfgRegistro.CfgRegistro=CfgRegistro.Nombre
CfgRegistro.Nombre=CfgRegistro.FechaCancelaciones
CfgRegistro.FechaCancelaciones=(Fin)
